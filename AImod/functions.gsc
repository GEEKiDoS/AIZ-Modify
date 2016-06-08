#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include AImod\_hud;
#include AImod\_OtherFunctions;
#include AImod\_botUtil;

init()
{
    level.totalPlayers = 0;
    level.ZombieCount = 0;
    level thread onPlayerConnect();
    level thread UICounterCash();
    level thread doDvars();

    level.allowupdate = true;
}

onPlayerConnect()
{
    self endon("disconnect");
    for(;;)
    {
        level waittill( "connected", player);
        level.totalPlayers++;

        player thread onPlayerSpawned();
        player thread hitmarkerColor();
        player thread SetTeam();
        player thread UpdateZM();
        player thread UpdateRound();
        player thread SetTeamWhenDead();
        player thread onPlayerDisconnect();
        player resetVars();
    }
}

onPlayerDisconnect()
{
    for(;;)
    {
        self waittill ( "disconnect" );
        level.totalPlayers--;
    }
}

onPlayerSpawned()
{
    self endon("disconnect");
    for(;;)
    {
        self waittill("spawned_player");
        self thread Main();
        self ClearLowerMessages();
    
        /#
        setDvar("g_speed", 500);
        self.maxhealth = 99999;
        self.health = self.maxhealth;
        self.money = 100000;
        self.cash = self.money;
        self notify("CASH");
        #/
    }
}

Main()
{
    wait 0.05;
    self SurvivorWeapons( getDvar("scr_aiz_spawn_weapon"), "allow" );
    self thread checkGun();
    self setClientDvar("ui_power", level.power);
    /* Ragdoll */
    self setClientDvar("ragdoll_enable", 1);
    self setClientDvar("ragdoll_max_simulating", 32);
}

SurvivorWeapons( weapon, grenades )
{
    self endon("death");
    self endon("disconnect");

    if( getDvar("g_gametype") == "aiz" || getDvar("g_gametype") == "war" || getDvar("g_gametype") == "exo" || getDvar("g_gametype") == "sd" || getDvar("g_gametype") == "grief" || getDvar("g_gametype") == "oneflag")
    {
        wait 0.2;
        self _giveWeapon( weapon );

        wait 0.2;
        self SwitchToWeapon( weapon );
	wait 1.6;
    	self thread checkIfHasWeapon( weapon, grenades );
    }
    if( isDefined(grenades) )
        self setweaponammoclip("semtex_mp", 3); 
    wait 1.6;
    self thread checkIfHasGrenades(grenades);
}

checkIfHasWeapon(weapon, grenades)
{
    if( !(self hasWeapon( weapon ) ) && self GetCurrentWeapon() != weapon )
    {
        self _giveWeapon( weapon );
        self SwitchToWeapon( weapon );
        if( isDefined(grenades) )
            self setweaponammoclip("semtex_mp", 3); 
        wait 0.2;
    }
}

checkIfHasGrenades(grenades)
{
    if( isDefined(grenades) )
        self setweaponammoclip("semtex_mp", 3); 
    wait 0.2;
}

checkGun()
{
    self endon( "death" );
    self endon( "disconnect" );
    
   for(;;)
   {
        self waittill( "weapon_change", newWeapon );  
        
        switch( newWeapon )
        {
			case "sa80_grip_xmags_mp":
			self setClientDvar( "cg_gun_z", 0.2 );
			self setClientDvar( "cg_gun_y", 0 );
			self setClientDvar( "cg_gun_x", 0 );
			break;

			case "m21_acog_mp":
			case "m21_acog_xmags_mp":
			self setClientDvar( "cg_gun_z", 0.15 );
			self setClientDvar( "cg_gun_y", 0.66 );
			self setClientDvar( "cg_gun_x", 0 );
			break;

			case "deserteagle_tactical_mp":
			case "deserteagle_fmj_tactical_mp":
			self setClientDvar( "cg_gun_z", -0.34 );
			self setClientDvar( "cg_gun_y", 0 );
			self setClientDvar( "cg_gun_x", 0 );
			break;

			case "wa2000_acog_xmags_mp":
			self setClientDvar( "cg_gun_z", -0.3 );
			self setClientDvar( "cg_gun_y", 1.2 );
			self setClientDvar( "cg_gun_x", 0 );
			break;

			case "cheytac_fmj_mp":
			self setClientDvar( "cg_gun_z", 1.25 );
			self setClientDvar( "cg_gun_y", 0 );
			self setClientDvar( "cg_gun_x", 0 );
			break;

			case "fn2000_reflex_mp":
			self setClientDvar( "cg_gun_y", -0.07 );
			self setClientDvar( "cg_gun_z", 0 );
			self setClientDvar( "cg_gun_x", 0 );
			break;

			case "tavor_fmj_reflex_mp":
			self setClientDvar( "cg_gun_z", -0.2 );
			self setClientDvar( "cg_gun_x", -0.5 );
			self setClientDvar( "cg_gun_y", 0 );
			break;

			case "masada_mp":
			self setClientDvar( "cg_gun_z", 1.5 );
			self setClientDvar( "cg_gun_x", 0 );
			self setClientDvar( "cg_gun_y", -0.65 );
			break;

			case "m240_grip_reflex_mp":
			self setClientDvar( "cg_gun_z", -10 );
			self setClientDvar( "cg_gun_x", 0 );
			self setClientDvar( "cg_gun_y", 0 );
			break;

			case "deserteagle_mp":
			self setClientDvar( "cg_gun_z", 1 );
			self setClientDvar( "cg_gun_x", 0 );
			self setClientDvar( "cg_gun_y", 2.25 );
			break;

			case "pp2000_akimbo_mp":
			self setClientDvar( "cg_gun_z", 0 );
			self setClientDvar( "cg_gun_x", -6.5 );
			self setClientDvar( "cg_gun_y", -0.5 );
			break;

			case "pp2000_akimbo_silencer_mp":
			self setClientDvar( "cg_gun_z", 0 );
			self setClientDvar( "cg_gun_x", -11 );
			self setClientDvar( "cg_gun_y", 0 );
			break;

			case "aug_mp":
			self setClientDvar( "cg_gun_z", 0.2 );
			self setClientDvar( "cg_gun_x", 0.8 );
			self setClientDvar( "cg_gun_y", 0 );
			break;

			case "uzi_mp":
			self setClientDvar( "cg_gun_z", -0.6 );
			self setClientDvar( "cg_gun_x", 0 );
			self setClientDvar( "cg_gun_y", 0 );
			break;
			
			case "famas_mp":
			self setClientDvar( "cg_gun_z", -0.2 );
			self setClientDvar( "cg_gun_x", -1.8 );
			self setClientDvar( "cg_gun_y", -0.02 );
			break;

			case "famas_fmj_reflex_mp":
			self setClientDvar( "cg_gun_z", -0.15 );
			self setClientDvar( "cg_gun_x", -1.8 );
			self setClientDvar( "cg_gun_y", 0 );
			break;

			case "aug_acog_xmags_mp":
			self setClientDvar( "cg_gun_z", 0.2 );
			self setClientDvar( "cg_gun_x", 0.8 );
			self setClientDvar( "cg_gun_y", 0 );
			break;

			default:
			self setClientDvar( "cg_gun_z", 0 );
			self setClientDvar( "cg_gun_y", 0 );
			self setClientDvar( "cg_gun_x", 0 );
			break;

        }
    }
}

hitmarkerColor()
{
    while ( true )
    {
        while( !isDefined( self.hud_damagefeedback ) )
        {
            wait 0.5;
        }

        self.hud_damagefeedback.color = getGoodColor();
        wait 0.5;
    }
}

getGoodColor()
{
    color = []; //Array as Vector3
    
    for( i=0;i<3;i++)
    {
        color[i] = randomint( 2 );
    }
    
    if( color[0] == color[1] && color[1] == color[2] )
    {
        rand = randomint(3);
        color[rand] += 1;
        color[rand] %= 2;
    }
    
    return ( color[0], color[1], color[2] );
}

UICounterCash()
{
    while( true )
    {
        wait 0.05;
        foreach( player in level.players )
        {
            player setClientDvar("ui_money", player.money);
            player setClientDvar("ui_bonus", player.bonus);
        }
    }
}

UpdateZM()
{
    self endon("disconnect");

    for(;;)
    {
        level waittill_any("zombie_spawned", "zombie_died");

        AImod\_botUtil::ZombieCountForHud();
        self setClientDvar("ui_zombies", level.ZombieCount);
    }
}

UpdateRound()
{
    self endon("disconnect");

    for(;;)
    {
        level waittill_either("zombie_round_started_end", "start_zombie_round");

        self setClientDvar("ui_wave", level.wave);
    }
}

SetTeam() //Intricate - MW2 by default doesn't have an 'auto-spawner' so this is my way.
{
    classnum = randomIntRange(1, 6);
    waittillframeend;
    if( level.zState == "intermission" )
    {
        self notify("menuresponse", game["menu_team"], "allies");
        waittillframeend;
        self notify("menuresponse", "changeclass", "class" + classnum);
        waittillframeend;
    }
    else
    {
        self notify("menuresponse", game["menu_team"], "spectator");
        waittillframeend;   
        self allowSpectateTeam( "freelook", true );
    }
}

SetTeamWhenDead()
{
    self endon("disconnect");
    for(;;) 
    {
        level waittill_either("zombie_round_started_end", "start_zombie_round");
        
        if( !isAlive(self) )
            self thread ForceRespawnPlayer(true);
    }
}

doDvars()
{
    //Main Dvars -------------------
    setDvar( "ui_allow_teamchange", 0 );
    setDvar( "ui_allow_classchange", 0 );
    setDvar( "g_speed", 190 );
    setDvar( "g_hardcore", 0 );
    setDvar( "scr_diehard", 1 );
    setDvar( "scr_war_timelimit", 0 );
    //setDvar( "g_ScoresColor_Allies", "0.3 0.9 0.9 0.9" );
    //setDvar( "g_TeamColor_Allies", "0.3 0.9 0.9 0.9" );
    setDvar( "scr_player_forcerespawn", 0 );
    setDvar( "scr_game_spectatetype", 3);
    
    /* Connection Dvars */  
    if(getDvar("z_dedicated") == "")
        setDvar( "z_dedicated", 0 );            //If Dedicated Server or Not 0 = Not Server 1 = Server
        
    /* Primary Dvars */
    setDvarIfUninitialized("ui_wave", 0);       //put this here to start the ui for wave counter
    setDvarIfUninitialized("ui_zombies", 0);    //put this here to start the ui for zombie counter
    setDvarIfUninitialized("ui_money", 0);      //put this here to start the ui for money
    setDvarIfUninitialized("z_friend", 0);      //FRIENDS :D
    setDvarIfUninitialized( "z_money", 500 );   //Start Money
    setDvarIfUninitialized( "z_waves", 30 );    //Waves
    if(getDvar("g_gametype") == "aiz_h" || getDvar("g_gametype") == "aiz_v")
    {
        if(getDvarInt("z_waves") < 50)
            setDvar("z_waves", 50);
    }
    
    level.MaxWaves = getDvarInt("z_waves");     //can change
    setDvarIfUninitialized( "z_endgame", 1 );
    
    if(getDvar("g_gametype") == "war")
        setDvar( "z_doa", 0 ); 
    if(getDvar("g_gametype") == "arcade")
    {
        setDvar( "z_doa", 1 );              
    }
    else
    {
        setDvar( "z_doa", 0 );   
    }
    if(getDvar("g_gametype") == "z_gg")
    {
        setDvar( "z_no_spawn_equipment", 1 );
    }
    if(getDvar("z_developer") == "")
        setDvar( "z_developer", "none" );
        
    setDvarIfUninitialized( "scr_aiz_spawn_weapon", "beretta_mp" );
    setDvarIfUninitialized( "give_weapon", 1 );
    setDvarIfUninitialized( "z_find", 1 );
    
    /* Killstreak Dvars */
    setDvarIfUninitialized( "z_25", 25 );                   //Something :D? 
    setDvarIfUninitialized( "z_predator_missile", 50 );     //Kills for Predator
    setDvarIfUninitialized( "z_random_1", 75 );             //Random Killstreak x1
    setDvarIfUninitialized( "z_sentry", 100 );              //Sentry gun
    setDvarIfUninitialized( "z_airstrike", 125 );           //Kills for Airstrike
    setDvarIfUninitialized( "z_random_4", 150 );            //Random killstreak x4
    setDvarIfUninitialized( "z_sub", 175 );                 //Sub machine gun team
    setDvarIfUninitialized( "z_vision", 250 );              //Restore the vision
    setDvarIfUninitialized( "z_super", 275 );               //Super Airstrike
    setDvarIfUninitialized( "z_lmg", 300 );                 //LMG team
    setDvarIfUninitialized( "z_megastrike", 500 );          //Mega airstrike
    setDvarIfUninitialized( "z_nuke", 650 );                //Nuke to end the round
    setDvarIfUninitialized( "z_permbot", 1000 );            //Permanent bot
    
    /* Sharp Shooter Killstreak Dvars */
    setDvarIfUninitialized( "z_perk_1", 50 );               //Perk 1
    setDvarIfUninitialized( "z_perk_2", 100 );              //Perk 2
    setDvarIfUninitialized( "z_perk_3", 150 );              //Perk 3
    setDvarIfUninitialized( "z_perk_4", 200 );              //Perk 4
    setDvarIfUninitialized( "z_perk_5", 250 );              //Perk 5
    setDvarIfUninitialized( "z_perk_6", 300 );              //Perk 6
    setDvarIfUninitialized( "z_perk_7", 350 );              //Perk 7
    setDvarIfUninitialized( "z_kill_1", 450 );              //Random Killstreak 1
    setDvarIfUninitialized( "z_kill_2", 600 );              //Random Killstreak 2
    setDvarIfUninitialized( "z_kill_3", 750 );              //Random Killstreak 3

    
    if(getDvarInt("z_developer") == 1)
    {
        setDvar("scr_player_maxhealth",100000);
        setDvar("bg_falldamagemaxheight" ,1000000);
        setDvar("bg_falldamageminheight" ,9999);
        setDvar("jump_height",500);
        setDvar("z_find",0);
        setDvar("g_speed", 400);
        Announcement("Developer Mode On, Bitch Please He's probably using this to Cheat");
    }

    if( GetDvarInt("z_dedicated") == 0 )
        level.is_dedicated_server = false;
    else
        level.is_dedicated_server = true;

    if( getDvarInt("z_no_spawn_equipment") == 0 )
        level.spawn_equipment = true;
    else
        level.spawn_equipment = false;

    if( GetDvarInt("z_doa") == 0 )
        level.mode_doa = false;
    else
        level.mode_doa = true;
        
}

ForceRespawnPlayer(override)
{
    self endon("disconnect");
    
    if(self.team != "allies")
        self thread SetTeam();

    if(self.team == "allies" || (override && self.team == "allies"))
    {
        self thread maps\mp\gametypes\_playerlogic::respawn_asSpectator( self.origin + (0, 0, 60), self.angles );
        self thread maps\mp\gametypes\_playerlogic::spawnPlayer();
    }
}

resetVars()
{
    self SetClientDvar("ui_wave", level.Wave);              //put this here to start the ui for wave counter
    self SetClientDvar("ui_zombies", level.ZombieCount);    //put this here to start the ui for zombie counter
    self SetClientDvar("ui_money", GetDvarInt("z_money"));  //put this here to start the ui for money
    self setClientDvar("ui_power", level.power);            //put this here to start the ui for power
}