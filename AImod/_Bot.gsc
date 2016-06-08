#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include AImod\_multi;
#include AImod\animation;
#include AImod\_OtherFunctions;
#include AImod\_round_utility;
#include AImod\_weapon;
#include AImod\_text;
#include AImod\_bonusdrops;
#include AImod\_DoaBonusDrops;

BotMain()
{
    level.Wave++;
    level thread UpdateVariables();
    CreateBotWave( getType() );
}
 
UpdateVariables()
{
    /* Variables */
    level.NextZombies = [];
    level.NextZombies[ "normal_zombie" ]  = 10 * level.Wave;
    level.NextZombies[ "zombie_crawler" ] = 5 * level.Wave;
    level.NextZombies[ "zombie_boss" ]    = 1;
    level.NextZombies[ "hell_spec" ]      = 10 * level.Wave;
    level.NextZombies[ "hell_boss" ]      = 1;
    level.NextZombies[ "hell_normal" ]    = 20 * level.Wave;

    level.MaxZombieCount = 30;
    if(getDvar("g_gametype") == "arcade" || getDvar("g_gametype") == "grief" || getDvar("g_gametype") == "aiz_v" || getDvar("g_gametype") == "aiz_h" || getDvar("g_gametype") == "exo" || getDvar("g_gametype") == "sd" || getDvar("g_gametype") == "dm"  || getDvar("g_gametype") == "sab" || getDvar("g_gametype") == "koth" || getDvar("g_gametype") == "oneflag")
        level.MaxZombieCount = 40;
}
 
CreateBotWave(type)
{
    level endon("game_ended");
    if (level.mode_doa == 0) 
    {
        switch(type)
        {
            case "zombie_crawler":
            level.crawlers = 1;
            break;
            case "zombie_boss":
            level.boss = 1;
            break;
            case "hell_spec":
            level.hellzombie = 1;
            break;
            case "hell_boss":
            level.hellboss = 1;
            break;
        }
        level Set_and_Init_Round(type);
        level thread Set_And_Tell_Players(type);
        level thread ZombieSound();
        if (level.Wave > 5 && !isSubstr( type, "boss"))
        level thread ZombieSound();
        if (level.Wave > 15 && !isSubstr( type, "boss"))
        level thread ZombieSound();
        for( i = 0;i < level.BotsForWave;i++ )
        {
            while(AImod\_botUtil::ZombieCount() >= level.MaxZombieCount)
            {
                wait 0.5;
            }
            while(level.kaboom == 1)
            {
                wait 0.5;
            }
            if(level.RealSpawnedBots < level.BotsForWave)
            {
                level.RealSpawnedBots++;
            }
            level.bots[i] = SpawnZombie( type );
            level.bots[i].id = i;
            wait 0.5; 
        }
        level thread MonitorFinish(type); 
    }
    else //Chaos Zombies
    {
        level.crawlers = 1;
        level.boss = 1;
        level.hellzombie = 1;
        level.hellboss = 1;
        level Set_and_Init_Round(type);
        level thread Set_And_Tell_Players(type);
        level thread ZombieSound();
        level thread ZombieSound();
        level thread ZombieSound();
        for( i = 0;i < level.BotsForWave;i++ )
        {
            while(AImod\_botUtil::ZombieCount() >= level.MaxZombieCount)
            {
                wait 0.5;
            }
            while(level.kaboom == 1)
            {
                wait 0.5;
            }
            if(level.RealSpawnedBots < level.BotsForWave)
            {
                level.RealSpawnedBots++;
            }
            if(i== 99 || i== 199| i== 299| i== 399| i== 499)
                level.bots[i] = SpawnZombie("hell_boss");
            else if(i== 599 || i== 699| i== 799| i== 899| i== 999)
                level.bots[i] = SpawnZombie("zombie_boss");
            else
            {
                randomCount = randomInt(30);
                switch(randomCount)
                {
                    case 1:
                    case 2:
                    case 3:
                    level.bots[i] = SpawnZombie("zombie_crawler");
                    break;
                    case 10:
                    case 11:
                    case 12:
                    case 13:
                    case 14:
                    case 15:
                    level.bots[i] = SpawnZombie("hell_spec");
                    break;
                    default:
                    level.bots[i] = SpawnZombie("hell_normal");
                    break;              
                }
            }
            wait 0.5; 
        }
        level thread MonitorFinish(type); 
    }
}

SoundFx(sound)
{
    prefix = tableLookup( "mp/factionTable.csv", 0, "opforce_airborne", 7 ) + "1_";
    soundAlias = prefix + sound;
    //self thread maps\mp\gametypes\_battlechatter_mp::doSound(soundAlias); //ka cheng gou
    self PlaySoundToTeam(soundAlias,"allies",self);
}


SpawnZombie( type ) //Spawn zombie through function
{
    level notify("zombie_spawned");
    
    zombie = spawn("script_model", AImod\_botUtil::GetMapSpawnPoint()+(randomIntRange(-20,20),randomIntRange(-20,20),0));
    zombie.head = spawn("script_model", zombie.origin);
    zombie Set_Zombie_Model_Type(type);
    zombie Spawn_Damage_Box(type);
    zombie Set_Zombie_Variables(type);
    if(isSubstr( type, "boss") )
        zombie play_CoolZombieDropIn();
    zombie Set_Init_Anim_Type(type);
    zombie Set_Zombie_Threads();
    
    
    if(isSubstr( type, "boss"))
    {
        zombie thread flareEffect();
        foreach( player in level.players )
        {
            player thread AImod\_text::GamblerText("Incoming Heavy Zombie!", (1,1,1), (1,0,0), 1, 0.85);
        }
    }
    
    //zombie thread SoundFx("inform_attack_thwc4");
    
    return zombie;
}

Set_Zombie_Variables(type)
{
    self.hasMarker = false;
    self.team = "axis";
    self.targetname = "bot";
    self.classname = "bot";
    self.currentsurface = "default";
    self.pers["isAlive"] = "true";
    self.type = type;
    self.isOnCompass = false;
}

Set_Zombie_Threads()
{
    if( !level.mode_doa ) 
        self thread BonusDrops();
    if( level.mode_doa ) 
        self thread BonusDropsDeadOps();
    self thread MonitorAttackPlayers( );
    self thread MonitorBotHealth();
    self thread KillIfUnderMap();
    self thread MoniterPosition();
    self thread GetBestPlayerAndMoveTo(); 
}

Spawn_Damage_Box(type)
{
    self.crate1 = spawn("script_model", self getTagOrigin( "j_spinelower" ) + (-5,0,-10));
    self.crate1 setModel("com_plasticcase_beige_big");
    self.crate1 CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
    self.crate1.angles = (90,0,0);
    self.crate1 Solid();
    self.crate1 hide();
    self.crate1.team = "axis";
    self.crate1 setCanDamage(true);
    if(level.mode_doa)
    {
        self.crate1.maxhealth = level.ZombieHealths[ type ] + level.ZombieHealthFactor[ type ];
        self.crate1.health = level.ZombieHealths[ type ] + level.ZombieHealthFactor[ type ];
    }
    else
    {
        self.crate1.maxhealth = level.ZombieHealth;
        self.crate1.health = level.ZombieHealth;
    }
    
    self.crate1 linkto( self, "j_spine4" );
}

Set_and_Init_Round(type)
{
    level.zState = "playing";
    level notify("zombie_round_started_end");
    level notify("crate_gone");
    level notify("clear_tombstones");
    level.RealSpawnedBots = 0;
    if (level.mode_doa == 0) 
        level.BotsForWave = level.NextZombies[ type ];
    else
        level.BotsForWave = 1000;
    level.ZombieHealths[ type ] += level.ZombieHealthFactor[ type ];
    level.ZombieHealth = level.ZombieHealths[ type ];
}

Set_And_Tell_Players(type)
{
    if(type == "zombie_crawler" || type == "zombie_boss" || type == "hell_spec" || type == "hell_boss")
        MusicPlay( "mp_killstreak_pavelow", true );
    else
        MusicPlay( "mp_killstreak_choppergunner", true );
    foreach( player in level.players )
    {
        if (level.mode_doa == 0) 
            player thread RoundStartText("Wave " + level.Wave, 1, (1,1,1), (0.3,0.3,0.9), 0.85);
        else
            player thread RoundStartText("A large wave of zombies are coming !", 1, (1,1,1), (1,0,0), 0.85);
        player thread SetVision(1.5);
        player thread SetVisionPain();

        //if(type == "zombie_crawler" || type == "zombie_boss" || type == "hell_spec" || type == "hell_boss")
            //player playLocalSound("mp_killstreak_pavelow");
        //else
            //player PlayLocalSound("mp_killstreak_choppergunner");
    }
}

flareEffect()
{   
    if( !isDefined( level.flareFx ) )
        level.flareFx = loadFx( "smoke/signal_smoke_airdrop" );
        
    self waittill_any( "bot_is_dead", "bot_death");
        
    ent =  spawn( "script_model", PhysicsTrace( self.origin + (0,0,100), self.origin - (0,0,100) ));
    ent setmodel( "tag_origin" );
    ent playsound("smokegrenade_explode_default");
    
    PlayFx( level.flareFx, ent.origin );
}

ZombieSound()
{   
    level endon("humans_all_dead");
    level endon("round_ended");
    level endon("zombie_round_started_end");
    
    wait 1;
    for(;;)
    {
        zombie = level.bots[randomInt(level.BotsForWave)];
        if(IsDefined(zombie))
        {
            zombie thread SoundFx("inform_attack_grenade");
            wait 5;
        }
        wait 0.1;
    }
}

Set_Init_Anim_Type(type)
{
    animtype = type;
    
    switch(type)
    {
        case "normal_zombie":
        case "hell_normal":
        animtype = type + "_" + randomInt(4);
        break;
    }
    self RegisterAnimation(animtype);
    self thread ZombieAnimationForRound();
    self thread MoniterZombieSpeed();
}

Set_Zombie_Model_Type(type)
{
    self setModel(AImod\_botUtil::GetModelByType(type,false));
    self.head setModel(AImod\_botUtil::GetModelByType(type,true));

    self.head.angles = (270,0,270);
    self.head linkto( self, "j_spine4", (0,0,0), (0,0,0) );
}

getType( )
{       
        return level.waveType[ level.Wave ];
}

TypeSetup()
{   
    level.isHell = false;
       
        hell_maps = [];
        hell_maps["mp_subbase"] = 1;
        hell_maps["mp_estate"] = 1;
        hell_maps["mp_overgrown"] = 1;
    hell_maps["mp_crash"] = 1;
       
        level.isHell = isDefined( hell_maps[ getdvar("mapname") ] );
    if(getDvar("g_gametype") == "arcade" || getDvar("g_gametype") == "grief" || getDvar("g_gametype") == "aiz_v" || getDvar("g_gametype") == "aiz_h" || getDvar("g_gametype") == "exo" || getDvar("g_gametype") == "sd" || getDvar("g_gametype") == "dm"  || getDvar("g_gametype") == "sab" || getDvar("g_gametype") == "koth" || getDvar("g_gametype") == "oneflag")
        level.isHell = 1;
       
        level.waveType = [];
       
    boss          = [];
    boss[ true ]  = "hell_boss";
    boss[ false ] = "zombie_boss";
    
    spec          = [];
    spec[ true ]  = "hell_spec";
    spec[ false ] = "zombie_crawler";
    
    norm          = [];
    norm[ true ]  = "hell_normal";
    norm[ false ] = "normal_zombie";
    
    for( i = 1 ; i <= level.MaxWaves ; i++ )
    {
        if( i % 10 == 0 )
            level.waveType[ i ] = boss[ level.isHell ];
            
        else if( i % 10 == 5 )
            level.waveType[ i ] = spec[ level.isHell ];
            
        else
            level.waveType[ i ] = norm[ level.isHell ];
    }
}

Give_Player_Round_End_Threads(type)
{
    switch(type)
    {
        case "normal_zombie":
        self thread HudRightMessage("$100 Bonus Cash", (1,1,1), (0.3,0.9,0.3), 0.85, 0.85);
        self thread maps\mp\gametypes\_rank::scorePopup( 100, 0, (0,1,0), 1 );
        self thread maps\mp\gametypes\_rank::giveRankXP("round_survived", 2);
        break;
        case "zombie_crawler":
        self thread HudRightMessage("$500 Bonus Cash & Max Ammo", (1,1,1), (0.3,0.9,0.3), 0.85, 0.85);
        self thread maps\mp\gametypes\_rank::scorePopup( 500, 0, (0,1,0), 1 );
        self thread maps\mp\gametypes\_rank::giveRankXP("round_survived", 2);
        self maps\mp\killstreaks\_airdrop::refillAmmo();
        break;
        case "zombie_boss":
        self thread HudRightMessage("$2000 Bonus Cash & Max Ammo", (1,1,1), (0.3,0.9,0.3), 0.85, 0.85);
        self thread maps\mp\gametypes\_rank::scorePopup( 2000, 0, (0,1,0), 1 );
        self thread maps\mp\gametypes\_rank::giveRankXP("round_survived", 2);
        self maps\mp\killstreaks\_airdrop::refillAmmo();
        break;
        case "hell_normal":
        self thread HudRightMessage("$200 Bonus Cash", (1,1,1), (0.3,0.9,0.3), 0.85, 0.85);
        self thread maps\mp\gametypes\_rank::scorePopup( 200, 0, (0,1,0), 1 );
        self thread maps\mp\gametypes\_rank::giveRankXP("round_survived", 2);
        break;
        case "hell_spec":
        self thread HudRightMessage("$1000 Bonus Cash & Max Ammo", (1,1,1), (0.3,0.9,0.3), 0.85, 0.85);
        self thread maps\mp\gametypes\_rank::scorePopup( 1000, 0, (0,1,0), 1 );
        self thread maps\mp\gametypes\_rank::giveRankXP("round_survived", 2);
        self maps\mp\killstreaks\_airdrop::refillAmmo();
        break;
        case "hell_boss":
        self thread HudRightMessage("$4000 Bonus Cash & Max Ammo", (1,1,1), (0.3,0.9,0.3), 0.85, 0.85);
        self thread maps\mp\gametypes\_rank::scorePopup( 4000, 0, (0,1,0), 1 );
        self thread maps\mp\gametypes\_rank::giveRankXP("round_survived", 2);
        self maps\mp\killstreaks\_airdrop::refillAmmo();
        break;
    }
}

setRoundEndVariables()
{
    level.zState = "intermission";
    level.crawlers = 0;
    level.boss = 0;
    level.hellzombie = 0;
    level.hellboss = 0;
}

givePlayerRoundEnd(type)
{
    MusicPlay( "mp_killstreak_stealthbomber", true );
    foreach( player in level.players )
    {
        player Give_Player_Round_End_Threads(type);
        player.gambler = 0;
        player.money += 100;
        player setweaponammostock( "semtex_mp", 3 );
        player thread RoundEndText("Wave " + level.Wave + " Survived", 1, (1,1,1), (0.3,0.9,0.3), 0.85);
        player thread IntermissionText(level.IntermissionTimeRound + " Second Intermission", 1, (1,1,0.5), (1,1,0.5), 0);
        player thread SetVision(1.5);
        player thread SetVisionPain();

        //player playLocalSound("mp_killstreak_stealthbomber");     
    }
}

MonitorFinish(type)
{
    level endon("crate_gone");
    for(;;)
    {
        if( AImod\_botUtil::ZombieCount() <= 0 )
        {
            if(level.Wave < level.MaxWaves && level.mode_doa == 0)
            {
                level setRoundEndVariables();
                level givePlayerRoundEnd(type);
                wait 2.5;
                level notify("round_ended");
                level notify("zombie_round_started_end");
                break;
            }
            else
            {
                level thread mp\maps\HeliCrash::KillerHeli();
                break;
            }
        }
        wait 0.05;
    }
}

removeEnt()
{
    self hide();
    self notSolid();
    self delete();
}

killZombieOnIntermission()
{
    self endon("bot_is_dead");
    level waittill("round_ended");
    
    self thread removeEnt();
    self.head thread removeEnt();
    self.c4 thread removeEnt();
    self.knife thread removeEnt();
    self.shield thread removeEnt();
    
    deletion( self );
    
    self notify("bot_is_dead");
}


MonitorBotHealth()
{
    self endon("bot_is_dead");
    pTemp = "";
    
    self thread killZombieOnIntermission();
    
    for(;;)
    {
        self.crate1 waittill("damage", iDamage, attacker, iDFlags, vPoint, type, victim, vDir, sHitLoc, psOffsetTime, sWeapon); 
        
        if( isDefined( attacker.type ) && attacker.type == "sentry" && isDefined( attacker.owner ) )
        {
            attacker = attacker.owner;
        }
            
        self thread ZombieHit(iDamage, attacker, iDFlags, vPoint, type, victim, vDir, sHitLoc, psOffsetTime, sWeapon);
        
        if( (self.crate1.health <= 0) && (self.name != pTemp) )
        {
            level thread deletion( self );
            self thread DeleteZombie();
            playFx(level.bloodfx,vPoint);
            attacker thread AttackerGain();
            if(self.type != "zombie_crawler")
                self scriptModelPlayAnim("pb_stand_death_headshot_slowfall");   
            wait 0.20;
            if(self.type != "zombie_crawler" && !isSubstr( self.type, "boss"))
                self startRagDoll(1);
            if(self.type == "zombie_crawler")
                self moveTo(self.origin+(0,0,2500), 5);
            else if(isSubstr( self.type, "boss"))
            {
                self moveTo(self.origin-(0,0,500), 5);
            }
            wait 0.05;
            PhysicsExplosionSphere( vPoint, 30, 30, randomIntRange(1,3) );
            //self thread DeathSound(); //Death Sound
            if(attacker.usingairstrike == "true")
            {
                attacker thread ZombieAirstrikeSound(sWeapon);
            }
            if(IfCanBlowUp(sWeapon) == true)
                self blowBackGrenade(vPoint);
            if(IfCanSetOnFire(sWeapon) == true)
            {
                self thread ZombieFireFx();
            }
            wait 2;
            wait 3;
            pTemp = self.name;
            wait 0.1;
            self notify("bot_is_dead");
        }
        wait 0.05;
    }
}

ZombieHit(iDamage, attacker, iDFlags, vPoint, type, victim, vDir, sHitLoc, psOffsetTime, sWeapon)
{
    self endon("bot_death");
    level endon("round_ended");
    attacker thread maps\mp\gametypes\_damagefeedback::updateDamageFeedback(sHitLoc);
    {
        self notify("hit");
        if(level.insta_ko == 1 && !isSubstr( self.type, "boss"))
        {
            self.crate1.health -= ( self.crate1.maxhealth + 1 );
        }
        if(attacker.stoppingpower == 1)
        {
            self.crate1.health -= iDamage;
        }
        if(self.type != "zombie_crawler")
        {
            self thread HitPainAnim();
        }
        playFx(level.bloodfx,vPoint);
        attacker.shots++;
        attacker thread EarnMoney( 10 );
        if(sWeapon == "pavelow_minigun_mp")
            self.crate1.health += 20;
        self thread ZombieAwareness();
        if(attacker.phd == 1 && type == "MOD_MELEE")
        {
        		boomnum = randomInt(2);
        		if(boomnum == 1)
        		{
        				RadiusDamage(self.origin, 500, 2000, 500, attacker, "MOD_EXPLOSIVE", "nuke_mp");
        				playfx(loadfx("explosions/tanker_explosion"),attacker.origin);
        				attacker playsound("cobra_helicopter_crash");
        		}
        }
    }
}

deletion( zombie )
{
    if( isDefined( level.bots[zombie.id] ) )
        level.bots[zombie.id] = undefined;
}

AttackerGain()
{
    self thread multikill();
    self thread playKillSound();
    self.kills++;
    self.pers["kills"] = self.kills;
    self thread EarnMoney( 50, true );
    self.pers["score"] = self.score;
    self.pers["botKillstreak"]++;
    self.amountofkillstreaks++;
    self thread maps\mp\gametypes\_rank::giveRankXP("zombie_kill", 25);
    self notify("zombie_killed");
}

EarnMoney( money, bool_bonus )
{
    if(level.double_points != 0)
        money *= 2;
    
    if( isDefined( bool_bonus ) && bool_bonus )
    {
        self.bonus++;
        
        if(level.double_points != 0)
            self.bonus++;
    }
    
    self.money += money;
    self.score += money;
    self thread maps\mp\gametypes\_rank::scorePopup( money, 0, (0,1,0), 1 );
    //self notify("MONEY");
}

DeleteZombie()
{
    self notify("bot_death");
    level notify("zombie_died");
    self.origin = self.origin;
    self.angles = self.angles;
    self.pers["isAlive"] = "false";
    self.knife delete();
    self.crate1 delete();
    self waittill("bot_is_dead");
    if(self.type == "zombie_crawler")
    {
        playFx(loadFx("props/barrelexp"), self getTagOrigin("j_head"));
        self playSound("explo_mine");
    }
    if(isSubstr( self.type, "boss"))
    {
        foreach(player in level.players)
        {
            player thread SetVision(1);
        }
    }
    self StopSounds();
    self delete();
    self.head delete();
    self.c4 delete();
    self.knife delete();
    self.shield delete();
}

playKillSound()
{
    wait 1;
    switch(randomInt(40))
    {
        case 0:
        self playSound( maps\mp\gametypes\_teams::getTeamVoicePrefix( self.team )+"mp_rsp_greatshot" );
        break;
        case 1:
        self playSound( maps\mp\gametypes\_teams::getTeamVoicePrefix( self.team )+"mp_cmd_suppressfire" );
        break;
    }
}

BotMoveWaypoints()
{
    if(self.automove == 1)
    {
        return;
    }
    self endon("stop_auto_move");
    self endon("bot_death");
    TmpDist = 0;
    pTarget = undefined;
    pWaypoint = undefined;
    movetoLoc = undefined;
    if(!isDefined(self.currentwaypoint))
    {
        self.currentwaypoint = level.botwaypoints[999999999999999];
    }
    if(isDefined(level.botwaypoints))
    {
        for(i = 0; i < level.botwaypoints.size; i++)
        {
            if(distance(self.origin, level.botwaypoints[i].origin) > TmpDist && self.currentwaypoint != level.botwaypoints[i] && bulletTracePassed( self.origin+(0,0,75), level.botwaypoints[i].origin, false, self ))
            {
                TmpDist = distance(self.origin, level.botwaypoints[i].origin);
                pWaypoint = level.botwaypoints[i];
                announcement(level.botwaypoints[i]);
            }
        }
    }
    if(isDefined(pWaypoint))
    {
        self.automove = 1;
        self.currentwaypoint = pWaypoint;
        movetoLoc = VectorToAngles( pWaypoint.origin - self.origin );
        self RotateTo((0,movetoLoc[1],0), 0.1);
        self setAnim(self.animationrun, 0, "run");
        while(self.origin[0] != pWaypoint.origin[0])
        {
            trace = bulletTrace(self.origin + (0,0,50), self.origin + (0,0,-40), false, self);
            if(isdefined(trace["entity"]) && isDefined(trace["entity"].targetname) && trace["entity"].targetname == "bot")
                trace = bulletTrace(self.origin + (0,0,0), self.origin + (0,0,-40), false, trace["entity"]);
            self.origin = (trace["position"]);
            self.currentsurface = trace["surfacetype"];
            if(self.currentsurface == "none")
                self.currentsurface = "default";
            self MoveTo(pWaypoint.origin, (distance(self.origin, pWaypoint.origin) / self.speed));
            wait 0.2;
        }
        self.automove = 0;
    }
}

GetBestPlayerAndMoveTo( )
{
    self endon("bot_death");
    self endon("stop_bot");
    level endon("round_ended");
    
    for(;;)
    {
        TmpDist = 999999999;
        pTarget = undefined;
        pAngles = undefined;
        movetoLoc = undefined;

        while(self.freezed == 1 || getDvarInt("z_find") == 0)
        {
            //Clamp to the ground has been moved into one function
            trace = bulletTrace(self.origin + (0,0,30), self.origin + (0,0,-40), false, self);
            if(isdefined(trace["entity"]) && isDefined(trace["entity"].targetname) && trace["entity"].targetname == "bot")
                trace = bulletTrace(self.origin + (0,0,30), self.origin + (0,0,-40), false, trace["entity"]);
            self.origin = (trace["position"]);
            self.currentsurface = trace["surfacetype"];
            if(self.currentsurface == "none")
                self.currentsurface = "default";
                
            if(self.idleanimation == 0)
            {
                self setAnim(self.animationidle, 0, "idle");
                self.idleanimation = 1;
            }

            
            wait 0.1;
        }
            
        foreach( player in level.players )
        {
            if(level.zombie_blood == 1)
                continue;
                    
            if(!isAlive(player))
                        continue;
                
            if(level.teamBased && self.team == player.pers["team"])
                        continue;
                
            if( !bulletTracePassed( self.origin+(0,0,75), player.origin+(0,0,65), false, self ) && !bulletTracePassed( player.origin+(0,0,65), self.origin+(0,0,75), false, player ) )
                        continue;
                
            if(player.sessionstate != "playing")
                continue;
                
            if(player.inLastStand == true)
                continue;
                
            if(distancesquared(self.origin, player.origin) < TmpDist)
            {
                TmpDist = distancesquared(self.origin, player.origin);
                pTarget = player;
                pAngles = "player";
            }
        }
        if(pAngles == "player")
        {
            movetoLoc = VectorToAngles( pTarget.origin - self.origin );
        }
        if(!isDefined(pTarget))
        {
            if(!isDefined(level.botwaypoints[0]))
            {
                if(self.idleanimation == 0)
                {
                    self setAnim(self.animation.idle, 0, "idle");
                    self.idleanimation = 1;
                    //Clamp to the ground has been moved into one function
                    trace = bulletTrace(self.origin + (0,0,30), self.origin + (0,0,-100), false, self);
                    if(isdefined(trace["entity"]) && isDefined(trace["entity"].targetname) && trace["entity"].targetname == "bot")
                    {
                        trace = bulletTrace(self.origin + (0,0,30), self.origin + (0,0,-100), false, trace["entity"]);
                        if(isdefined(trace["entity"]) && isDefined(trace["entity"].targetname) && trace["entity"].targetname == "bot")
                        {
                            trace = undefined;
                        }
                    }
                    self.origin = (trace["position"]);
                    self.currentsurface = trace["surfacetype"];
                    if(self.currentsurface == "none")
                        self.currentsurface = "default";
                }
            }
            else
            {
                self thread BotMoveWaypoints();
            }
        }
        if(isDefined(pTarget))
        {
            if(self.idleanimation == 1)
            {
                self setAnim(self.animationwalk, 0, "walk");
                self.idleanimation = 0;
            }
            //Clamp to the ground has been moved into one function
            trace = bulletTrace(self.origin + (0,0,50), self.origin + (0,0,-40), false, self);
            if(isdefined(trace["entity"]) && isDefined(trace["entity"].targetname) && trace["entity"].targetname == "bot")
                trace = bulletTrace(self.origin + (0,0,50), self.origin + (0,0,-40), false, trace["entity"]);

            self.origin = (trace["position"]);
            
            self.currentsurface = trace["surfacetype"];
            if(self.currentsurface == "none")
                self.currentsurface = "default";
            self notify("stop_auto_move");
            self.automove = 0;
        }
        
        yaw = VectorToAngles( pTarget getTagOrigin("j_head") - self getTagOrigin( "j_head" ) )[1];
        self RotateTo((0,yaw,0), 0.3);
        self MoveTo(pTarget.origin, (distance(self.origin, pTarget.origin) / self.speed));
        
    wait 0.3;
    }
}


MonitorAttackPlayers( )
{
    self endon("bot_death");
    level endon("round_ended");
    
    while(isDefined(self))
    {
        foreach( player in level.players )
        {
            pTarget = player;
            if(distancesquared(player.origin, self.origin) <= 729 && player.inLastStand != true && player.inFinalStand != true && player.pers["team"] == "allies" && level.zombie_blood == 0)
            {
                self.knife = spawn("script_model", self getTagOrigin("tag_inhand"));
                self.knife setModel("weapon_parabolic_knife");
                self.knife.angles = (0,0,0);
                self.knife linkto( self, "tag_inhand" );
                self setAnim(self.animationmelee, 0, "melee");
                wait 0.15;
                playFx(level.bloodfx,self.origin+(0,0,30));
                player thread maps\mp\gametypes\_damage::finishPlayerDamageWrapper( self, self, 50, 0, "MOD_MELEE", "none", player.origin, player.origin, "none", 0, 0 );
                self thread SoundFx("inform_reloading_generic");
                wait 1;
                self.knife delete();
                self setAnim(self.animationsprint, 0, "sprint");
                self.shots += 4;
            }
        }
        wait 0.07;
    }
}

KillIfUnderMap()
{
    self endon("bot_is_dead");
    for(;;)
    {
        if((self.origin[2] <= -1585 && getDvar("mapname") == "mp_afghan") ||
        (self.origin[2] <= 100 && getDvar("mapname") == "mp_terminal") ||
        (self.origin[2] <= -350 && getDvar("mapname") == "mp_vacant") ||
        (self.origin[2] <= -100 && getDvar("mapname") == "mp_storm") ||
        (self.origin[2] <= -333 && getDvar("mapname") == "mp_rust" && level.edit == 0 || self.origin[2] <= -333 && getDvar("mapname") == "mp_rust" && level.edit == 1) ||
        (self.origin[2] <= -782 && getDvar("mapname") == "mp_estate") ||
        (self.origin[2] <= 1674 && getDvar("mapname") == "mp_highrise" && level.edit == 0) ||
        (self.origin[2] <= -113 && getDvar("mapname") == "mp_trailerpark") ||
        (self.origin[2] <= 32 && getDvar("mapname") == "mp_crash") ||
        (self.origin[2] <= -108 && getDvar("mapname") == "mp_highrise" && level.edit == 1) ||
        (self.origin[2] <= -1614 && getDvar("mapname") == "oilrig") ||
        (self.origin[2] <= -200 && getDvar("mapname") == "mp_brecourt") ||
        (self.origin[2] <= -2100 && getDvar("mapname") == "af_caves"))
        {
            damage = self.crate1.maxhealth + 1;
            self.crate1.health -= damage;
            self.crate1 notify("damage", damage);
            break;
        }
        wait 1;
    }
}

//------------------------------------------------------------------------------------------------------------------//
//---------------------------------------------- Compass display code ----------------------------------------------//
//------------------------------------------------------------------------------------------------------------------//

setupCompass( ammount )
{
    if( !isDefined( ammount ) )
        ammount = 5;
        
    reserveIDs( ammount );
    wait 0.1;
    level thread watchCompass();
    
}

ShowMeOnCompass( id, dog )
{
    if( self.isOnCompass )
        return false;
    
    self.isOnCompass = true;
    curObjID = level.compassID[ id ];
    objective_add( curObjID, "invisible", (0,0,0) );
    objective_position( curObjID, self.origin );
    objective_state( curObjID, "active" );
    objective_team( curObjID, "allies" );
    objective_icon( curObjID, "compassping_enemyfiring" );
    Objective_OnEntity( curObjID, self );
    
    self thread deleteWatcher( id, dog );
}

reserveIDs( ammount )
{   
    level.compassID = [];
    level.compassIDinUse = [];
    
    for(i=0;i<ammount;i++)
    {
        level.compassID[ i ] = maps\mp\gametypes\_gameobjects::getNextObjID();
        level.compassIDinUse[ i ] = false;
    }
}

getFreeIDIndex()
{       
    for(i=0;i<level.compassIDinUse.size;i++)
    {
        if(!level.compassIDinUse[ i ])
        {
            level.compassIDinUse[ i ] = true;
            return i;
        }
    }
    
    return false;
}

freeIDIndex()
{
    for(i=0;i<level.compassIDinUse.size;i++)
    {
        level.compassIDinUse[ i ] = false;
        objective_delete( level.compassID[ i ] );
    }
}

deleteObject( id )
{
    self waittill_any("bot_death", "no_compass");
    self notify("no_compass");
    self.isOnCompass = false;
    wait 0.1;
    objective_delete( level.compassID[ id ] );
    level.compassIDinUse[ id ] = false;
}

deleteWatcher( id, dog )
{
    self endon("no_compass");
    
    self thread deleteObject( id );
    if( isDefined( dog ) && dog )
    {
        while( isDefined( level.dogs[ self.id ] ) )
        {
            if( ( level.bots.size + level.dogs.size ) > level.compassID.size )
                self notify("no_compass");
            
            wait 1;
        }
    }
    
    else
    {
        while( isDefined( level.bots[ self.id ] ) )
        {
            if( ( level.bots.size + level.dogs.size ) > level.compassID.size )
                self notify("no_compass");
            
            wait 1;
        }
    }
    
    self notify("no_compass");
}

watchCompass()
{
    level waittill("zombie_round_started_end");
    
    wait 0.1;
    
    while( true )
    {
        freeIDIndex();
        wait 1;
        
        while( isDefined( level.bots ) && ( level.bots.size + level.dogs.size )<= level.compassID.size && level.RealSpawnedBots == level.BotsForWave)
        {   
            foreach( zombie in level.bots )
                if( !zombie.isOnCompass )
                    zombie thread ShowMeOnCompass( getFreeIDIndex() );
                    
            foreach( zombie in level.dogs )
                if( !zombie.isOnCompass )
                    zombie thread ShowMeOnCompass( getFreeIDIndex(), true );
    
            wait 1;
        }
        
        foreach( zombie in level.bots )
            level.bots[ zombie.id ].isOnCompass = false;
            
        foreach( zombie in level.dogs )
            level.bots[ zombie.id ].isOnCompass = false;
    }
}