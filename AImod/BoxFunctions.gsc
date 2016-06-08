#include common_scripts\utility; 
#include maps\mp\_utility; 
#include maps\mp\gametypes\_hud_util; 
#include maps\mp\gametypes\MapEdit; 
#include AImod\_OtherFunctions; 
#include AImod\_weapon; 
#include AImod\_hud; 
#include AImod\_text;

SpawnBoxes(model, pos, pos_add, angle, add_to_objective, add_to_headIcon, headSize, nameofItem, typeofBox, powerIsRequired, cashAmountRequired, perkVariable, perkName, perkHudColor)
{
    block = spawn("script_model", pos+pos_add );
    block setModel(model);
    block.angles = angle;
    block Solid();
    block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
    
    triggerString = getBoxString( nameOfItem );
    if(add_to_objective)
    {
        curObjID = maps\mp\gametypes\_gameobjects::getNextObjID();
        objective_add( curObjID, "invisible", (0,0,0) );
        objective_position( curObjID, block.origin );
        objective_state( curObjID, "active" );
        objective_team( curObjID, "allies" );
        objective_icon( curObjID, perkName );
    }

    if(add_to_headIcon)
        block thread BoxShader( perkName );

    if(typeofBox == "perkBox")
    {
        block moveto(pos,3);
        laptop = spawn("script_model", pos+(0,0,17) );
        laptop setModel("com_laptop_2_open");
        laptop.angles = angle;
        laptop Solid();
        laptop thread rotateLaptop();
        block thread PerkBoxFunction(pos, angle, powerIsRequired, cashAmountRequired, nameofItem, perkVariable, perkName, perkHudColor, triggerString);
    }
    else if(typeofBox == "gamblerBox")
    {
        block moveto(pos,3);
        laptop = spawn("script_model", pos+(0,0,17) );
        laptop setModel("com_laptop_2_open");
        laptop.angles = angle;
        laptop Solid();
        laptop thread rotateLaptop();
        block thread GamblerBoxFunction(pos, cashAmountRequired, nameofItem, laptop);
    }
    else if(typeofBox == "killstreakBox")
    {
        block moveto(pos,3);
        laptop = spawn("script_model", pos+(0,0,17) );
        laptop setModel("com_laptop_2_open");
        laptop.angles = angle;
        laptop Solid();
        laptop thread rotateLaptop();
        block thread KillstreakBoxFunction(pos, cashAmountRequired, nameofItem);
    }
    
    else if(typeofBox == "ammoBox")
    {
        block moveto(pos,3);
        laptop = spawn("script_model", pos+(0,0,17) );
        laptop setModel("com_laptop_2_open");
        laptop.angles = angle;
        laptop Solid();
        laptop thread rotateLaptop();
        block thread AmmoBoxFunction(pos, cashAmountRequired, nameofItem);
    }
    else if(typeofBox == "upgradeBox")
    {
        block moveto(pos,3);
        /* This is to make the Upgrade Box Solid -LifeLive42- */
        block2 = spawn("script_model", pos + (0,0,30));
        block2 setModel("com_plasticcase_friendly");
        block2.angles = angle;
        block2 Solid();
        block2 hide();
        block2 CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
        block thread UpgradeBoxFunction(pos, angle, powerIsRequired, cashAmountRequired, nameofItem);
    }
}

PerkBoxFunction(pos, angle, powerIsRequired, cashAmountRequired, nameOfItem, perkVariable, perkName, perkHudColor, triggerString)
{
    level endon("game_ended");
    
    self.trigger = Spawn( "trigger_radius", self.origin, 0, 50, 72 );
    self makeTeamUsable( "allies" );
    self useTriggerRequireLookAt();
    self SetCursorHint( "HINT_NOICON" );
    self SetHintString( "Requires Electricity!" );

    level waittill("power_activated");

    self SetHintString(triggerString);
    for(;;)
    {
        self.trigger waittill( "trigger", player );
        
        team = player.team;
        if( team == "allies" )
            isAllies = true;
        else
            isAllies = false;
            

        if( isAllies && player UseButtonPressed() )
        {
            if( player.money >= cashAmountRequired )
            {
                switch(nameOfItem)
                {
                    case "Quick Revive":
                        if(player.autorevive == 0)
                        {
                            if(player.autorevivecount >= 3)
                            {
                                player iPrintln("^1Only can buy three " + nameOfItem + "!");
                            }
                            else
                            {
                                player.money -= cashAmountRequired;
                                player notify("MONEY");
                                player thread maps\mp\gametypes\_rank::scorePopup( 0-cashAmountRequired, 0, (1,0,0), 1 );
                                player thread AImod\_Mod::TextPopup( nameOfItem + "!" );
                                player.autorevive = 1;
                                player.autorevivecount++;
                                player thread PerkBoxSound(nameOfItem);
                                player thread PerkBoxHud(perkName, perkHudColor, "Quick Revive");
                            }
                        }
                        else
                        {
                            player iPrintln("^1You have already bought " + nameOfItem + "!");
                        }
                        break;
                    case "Speed Cola":
                        if(player.speedreload == 0)
                        {
                            player.money -= cashAmountRequired;
                            player notify("MONEY");
                            player thread maps\mp\gametypes\_rank::scorePopup( 0-cashAmountRequired, 0, (1,0,0), 1 );
                            player thread AImod\_Mod::TextPopup( nameOfItem + "!" );
                            player.speedreload = 1;
                            player _setPerk("specialty_fastreload");
                            player _setPerk("specialty_quickdraw");
                            player thread PerkBoxSound(nameOfItem);
                            player thread PerkBoxHud(perkName, perkHudColor, "Speed Cola");
                        }
                        else
                        {
                            player iPrintln("^1You have already bought " + nameOfItem + "!");
                        }
                        break;
                    case "Juggernog":
                        if(player.juggernaut == 0)
                        {
                            player.money -= cashAmountRequired;
                            player notify("MONEY");
                            player thread maps\mp\gametypes\_rank::scorePopup( 0-cashAmountRequired, 0, (1,0,0), 1 );
                            player thread AImod\_Mod::TextPopup( nameOfItem + "!" );
                            player.juggernaut = 1;
                            player.maxhealth = 200;
                            player thread PerkBoxSound(nameOfItem);
                            player thread PerkBoxHud(perkName, perkHudColor, "Juggernog");
                        }
                        else
                        {
                            player iPrintln("^1You have already bought " + nameOfItem + "!");
                        }
                        break;
                    case "Stamin-Up":
                        if(player.speedy == 0)
                        {
                            player.money -= cashAmountRequired;
                            player notify("MONEY");
                            player thread maps\mp\gametypes\_rank::scorePopup( 0-cashAmountRequired, 0, (1,0,0), 1 );
                            player thread AImod\_Mod::TextPopup( nameOfItem + "!" );
                            player.speedy = 1;
                            player _setPerk("specialty_marathon");
                            player _setPerk("specialty_lightweight");
                            player _setPerk("specialty_fastsprintrecovery");
                            player thread PerkBoxSound(nameOfItem);
                            player thread PerkBoxHud(perkName, perkHudColor, "Stamin-Up");
                        }
                        else
                        {
                            player iPrintln("^1You have already bought " + nameOfItem + "!");
                        }
                        break;
                    case "Double Tap Root Beer":
                        if(player.stoppingpower == 0)
                        {
                            player.money -= cashAmountRequired;
                            player notify("MONEY");
                            player thread maps\mp\gametypes\_rank::scorePopup( 0-cashAmountRequired, 0, (1,0,0), 1 );
                            player thread AImod\_Mod::TextPopup( nameOfItem + "!" );
                            player.stoppingpower = 1;
                            player _setPerk("specialty_rof");
                            player thread PerkBoxSound(nameOfItem);
                            player thread PerkBoxHud(perkName, perkHudColor, "Double Tap II");
                        }
                        else
                        {
                            player iPrintln("^1You have already bought " + nameOfItem + "!");
                        }
                        break;
                    case "Deadshot Daiquiri":
                        if(player.deadshot == 0)
                        {
                            player.money -= cashAmountRequired;
                            player notify("MONEY");
                            player thread maps\mp\gametypes\_rank::scorePopup( 0-cashAmountRequired, 0, (1,0,0), 1 );
                            player thread AImod\_Mod::TextPopup( nameOfItem + "!" );
                            player.deadshot = 1;
                            player _setPerk("specialty_bulletaccuracy");
														player _setPerk("specialty_steelnerves");
                            player thread PerkBoxSound(nameOfItem);
                            player thread PerkBoxHud(perkName, (0.1,0.1,0.1), "Deadshot Daiquiri");
                        }
                        else
                        {
                            player iPrintln("^1You have already bought " + nameOfItem + "!");
                        }
                        break;
                    case "PhD Flopper":
                        if(player.phd == 0)
                        {
                            player.money -= cashAmountRequired;
                            player notify("MONEY");
                            player thread maps\mp\gametypes\_rank::scorePopup( 0-cashAmountRequired, 0, (1,0,0), 1 );
                            player thread AImod\_Mod::TextPopup( nameOfItem + "!" );
                            player.phd = 1;
                            player thread PerkBoxSound(nameOfItem);
                            player thread PerkBoxHud(perkName, (0.7,0.5,1), "PhD!");
                        }
                        else
                        {
                            player iPrintln("^1You have already bought " + nameOfItem + "!");
                        }
                        break;
                    case "Tombstone Soda":
                        if(player.tombstone == 0)
                        {
                            player.money -= cashAmountRequired;
                            player notify("MONEY");
                            player thread maps\mp\gametypes\_rank::scorePopup( 0-cashAmountRequired, 0, (1,0,0), 1 );
                            player thread AImod\_Mod::TextPopup( nameOfItem + "!" );
                            player.tombstone = 1;
                            player thread PerkBoxSound(nameOfItem);
                            player thread PerkTombstoneHud(perkName, (1,1,0.7), "Tombstone");
                        }
                        else
                        {
                            player iPrintln("^1You have already bought " + nameOfItem + "!");
                        }
                        break;
                    case "Mule Kick":
                        if(player.mulekick == 0)
                        {
                            player.money -= cashAmountRequired;
                            player notify("MONEY");
                            player thread maps\mp\gametypes\_rank::scorePopup( 0-cashAmountRequired, 0, (1,0,0), 1 );
                            player thread AImod\_Mod::TextPopup( nameOfItem + "!" );
                            player.mulekick = 1;
                            player.muletakeweapon = "none";
                            player thread PerkBoxSound(nameOfItem);
                            player thread PerkBoxHud(perkName, (1,0,0.2), "Mule Kick");
                        }
                        else
                        {
                            player iPrintln("^1You have already bought " + nameOfItem + "!");
                        }
                        break;
                    default:
                        break;
                }
                wait 1;
            }
            else
            {
                player iPrintln("^1Not enough cash for " + nameOfItem + ".  [COST: ^2$^3" + cashAmountRequired + "^7]");
                wait 1;
            }
        }
    }
}

PerkBoxSound(nameOfItem)
{
    if(nameOfItem == "Quick Revive")
        self playLocalSound( "UK_1mc_hq_offline" );
    else if(nameOfItem == "Speed Cola")
        self playLocalSound( "UK_1mc_hq_destroyed" );
    else if(nameOfItem == "Juggernog")
        self playLocalSound( "UK_1mc_hq_online" );
    else if(nameOfItem == "Stamin-Up")
        self playLocalSound( "UK_1mc_hq_located" );
    else if(nameOfItem == "Double Tap Root Beer")
        self playLocalSound( "UK_1mc_hq_captured" );
    else if(nameOfItem == "Stalker")
        self playLocalSound( "UK_1mc_hq_secured" );
    else if(nameOfItem == "Mule Kick")
        self playLocalSound( "UK_1mc_hq_secured" );
    else if(nameOfItem == "Deadshot Daiquiri")
        self playLocalSound( "UK_1mc_freeforall" );
    else if(nameOfItem == "PhD Flopper")
        self playLocalSound( "UK_1mc_hc_tm_death" );
    else if(nameOfItem == "Tombstone Soda")
        self playLocalSound( "UK_1mc_hc_captureflag" );
}

PerkBoxHud(perkName, perkHudColor, nameOfItem)
{
    self.zombieperks += 1;
    self thread PerkHud( perkName, perkHudColor, nameOfItem );
}

RandomWeapon(pos, angle)
{
    block = spawn("script_model", pos);
    block setModel("com_plasticcase_friendly");
    block.angles = angle;
    block Solid();
    block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
    block.headIcon = newHudElem();
    block.headIcon.x = block.origin[0];
    block.headIcon.y = block.origin[1];
    block.headIcon.z = block.origin[2] + 60;
    block.headIcon.alpha = 0.85;
    block.headIcon setShader( "weapon_m16a4", 10,30 );
    block.headIcon setWaypoint( true, true, false );
    if(level.boxicon == 0)
    {
        curObjID = maps\mp\gametypes\_gameobjects::getNextObjID();
        objective_add( curObjID, "invisible", (0,0,0) );
        objective_position( curObjID, block.origin );
        objective_state( curObjID, "active" );
        objective_team( curObjID, "allies" );
        objective_icon( curObjID, "weapon_m16a4" );
        //level thread RandomWeaponUpdateIconPosition(curObjID);
        level.boxicon = 1;
    }
    wait 0.05;
    block thread RandomWeaponThink(pos, angle);
}

RandomWeaponThink(pos, angle)
{
    level endon("game_ended");
    
    self.trigger = Spawn( "trigger_radius", self.origin, 0, 50, 72 );
    self.weapon_trigger = Spawn( "trigger_radius", self.origin, 0, 50, 72 );
    self makeTeamUsable( "allies" );
    self useTriggerRequireLookAt();
    self SetCursorHint( "HINT_NOICON" );

    self SetHintString( "Press & hold ^3[{+activate}]^7 to use Mystery Box. [Cost: ^2$^3950 ^7]" );

    self.weapon_model = spawn( "script_model", self.origin );
    self.weapon_model.angles = self.angles;
    boxOpenedBy = undefined;

    for(;;)
    {
        self.trigger waittill( "trigger", player );

        team = player.team;
        if( team == "allies" )
            isAllies = true;
        else
            isAllies = false;
            

        if( isAllies && player UseButtonPressed() )
        {
            if(player RandomWeaponCanUse() == 1)
            {
                if( level.fire_sale == 0)
                {
                    if( player.money >= 950 )
                    {
                        //Find better soundalias as this only plays 2d audio, need to get 3d!
                        playSoundInSpace( "mp_obj_returned",self.origin );
                        self.box_open = true;
                        boxOpenedBy = player;
                        player.money -= 950;
                        player notify("MONEY");
                        player thread maps\mp\gametypes\_rank::scorePopup( 0-950, 0, (1,0,0), 1 );
                        player thread AImod\_Mod::TextPopup( "Mystery Box!" );
                        self.trigger trigger_off();
                        self.weapon_model show();
                        self SetHintString( "" );
                        self thread RandomWeaponWeaponRandomizer( player );
                        self waittill("randomization_done");
                        self SetHintString( "Press & hold ^3[{+activate}]^7 to trade you weapon." );
                        wait 0.5;
                        self thread RandomWeaponTimeout();
                        self.weapon_trigger trigger_on();
                        while( 1 )
                        {
                            self.weapon_trigger waittill("trigger", grabber);

                            if( grabber == boxOpenedBy || grabber == level )
                            {
                                if( grabber == boxOpenedBy && grabber UseButtonPressed() && player RandomWeaponCanUse() == 1 && player.inLastStand != true )
                                {
                                    self notify("user_grabbed_weapon");
                                    grabber thread RandomWeaponGive( self.weapon_model.string );
                                    break;
                                }
                                else if( grabber == level )
                                    break;
                            }
                        }
                        self.weapon_model hide();
                        self.weapon_trigger trigger_off();
                        self.weapon_model.origin = self.origin;
                        self.trigger trigger_on();
                        self.box_open = false;
                        self SetHintString( "Press & hold ^3[{+activate}]^7 to use Mystery Box. [Cost: ^2$^3950 ^7]" );
                        wait 1;
                    }
                    else
                    {
                        player iPrintln("^1Not enough money for Mystery Box. ^7[Cost: ^2$^3950^7]");
                        wait 1;
                    }
                }
                else if (level.fire_sale == 1)
                {
                    if( player.money >= 10 )
                    {
                    //Find better soundalias as this only plays 2d audio, need to get 3d!
                    playSoundInSpace( "mp_obj_returned",self.origin );
                    self.box_open = true;
                    boxOpenedBy = player;
                    player.money -= 10;
                    player notify("MONEY");
                    player thread maps\mp\gametypes\_rank::scorePopup( 0-10, 0, (1,0,0), 1 );
                    player thread AImod\_Mod::TextPopup( "Mystery Box!" );
                    self.trigger trigger_off();
                    self.weapon_model show();
                    self SetHintString( "" );
                    self thread RandomWeaponWeaponRandomizer( player );
                    self waittill("randomization_done");
                    self SetHintString( "Press & hold ^3[{+activate}]^7 to take weapon." );
                    wait 0.5;
                    self thread RandomWeaponTimeout();
                    self.weapon_trigger trigger_on();
                    while( 1 )
                    {
                        self.weapon_trigger waittill("trigger", grabber);

                        if( grabber == boxOpenedBy || grabber == level )
                        {
                            if( grabber == boxOpenedBy && grabber UseButtonPressed() /*add check here for last stand and other stuff like death machine*/ )
                            {
                                self notify("user_grabbed_weapon");
                                grabber thread RandomWeaponGive( self.weapon_model.string );
                                break;
                            }
                            else if( grabber == level )
                                break;
                        }
                    }
                    self.weapon_model hide();
                    self.weapon_trigger trigger_off();
                    self.weapon_model.origin = self.origin;
                    self.trigger trigger_on();
                    self.box_open = false;
                    self SetHintString( "Press & hold ^3[{+activate}]^7 to use Mystery Box. [Cost: ^2$^3950 ^7]" );
                    wait 1;
                    }
                    else
                    {
                    player iPrintln("^1Not enough money for Mystery Box. ^7[Cost: ^2$^310^7]");
                    wait 1;
                    }
                }
            }
            else
            {
                player iPrintln("^1Can not use Mystery Box if you current weapon is killstreak weapon!");
            }
        }
    }
}

RandomWeaponCanUse()
{
	current_weapon = self GetCurrentWeapon();
  	randomweaponlist = level.weapons;
  	upgradelist = level.upgrade_weapon;
  	foreach(item in randomweaponlist)
  	{
  		item = current_weapon;
  		return 1;
  	}
  	foreach(item in upgradelist)
  	{
  		item = current_weapon;
  		return 1;
  	}
  	if(current_weapon == "aug_silencer_mp" || current_weapon == "mg4_silencer_mp")
  		return 1;
  	
  	return 0;
}

RandomWeaponWeaponRandomizer( user )
{
    modelName = undefined;
    randomWeap = undefined;
    number_cycles = 40;
    self.weapon_model.string = undefined;
    self.weapon_model MoveTo(self.weapon_model.origin+(0,0,40), 3);
    //Intricate - temporarily store level.weapons excluding our current weapons :)
    tempWeapArray = AImod\_waw::array_exclude( level.weapons, user GetWeaponsListAll() );
    for( i = 0; i < number_cycles; i++ )
    {
        if( i < 20 )
        {
            wait( 0.05 );
        }
        else if( i < 30 )
        {
            wait( 0.1 );
        }
        else if( i < 35 )
        {
            wait( 0.2 );
        }
        else if( i < 38 )
        {
            wait( 0.3 );
        }

        randomWeap = tempWeapArray[RandomInt( 65535 ) % tempWeapArray.size];
        modelName = GetWeaponModel( randomWeap );
        self.weapon_model SetModel( modelName );
        self.weapon_model HideGunParts( randomWeap );
    }

    self.weapon_model.string = randomWeap;
    waittillframeend;

    self notify("randomization_done");
    wait 0.5;
    self.weapon_model MoveTo(self.weapon_model.origin-(0,0,40), 12);
}

RandomWeaponTimeout()
{
    self endon( "user_grabbed_weapon" );

    wait 12;
    self.weapon_trigger notify("trigger", level);
}

RandomWeaponGive( weapon )
{
    primaryWeapons = self GetWeaponsListAll();
    current_weapon = undefined;
    weapon_limit = 2;
    if(self.mulekick == 1)
    	weapon_limit = 3;

    if( primaryWeapons.size >= weapon_limit + 1)
    {
        current_weapon = self GetCurrentWeapon();
        self TakeWeapon( current_weapon );
        self GiveWeapon( weapon );
        self GiveMaxAmmo( weapon );
        self SwitchToWeapon( weapon );
        if(self.mulekicktakeweapon == current_weapon)
        {
        	self.mulekicktakeweapon = weapon;
        }
    }
    else
    {
        self GiveWeapon( weapon );
        self GiveMaxAmmo( weapon );
        self SwitchToWeapon( weapon );
        if(self GetWeaponsListAll().size >=4 && self.mulekick == 1)
        {
        	self.mulekicktakeweapon = weapon;
        }
    }
}

KillstreakBoxFunction(pos, bonusPointsRequired, nameofItem)
{
    level endon("game_ended");
    
    self.trigger = Spawn( "trigger_radius", self.origin, 0, 50, 72 );
    self makeTeamUsable( "allies" );
    self useTriggerRequireLookAt();
    self SetCursorHint( "HINT_NOICON" );
    self SetHintString( "Press & hold ^3[{+activate}]^7 to buy a random killstreak. [Cost: ^3200 ^7Points]" );

    for(;;)
    {
        self.trigger waittill( "trigger", player );

        team = player.team;
        if( team == "allies" )
            isAllies = true;
        else
            isAllies = false;

        if( isAllies && player UseButtonPressed() )
        {
            if( player.bonus >= bonusPointsRequired)
            {
                player.bonus -= bonusPointsRequired;
                player notify("BONUS");
                player thread maps\mp\gametypes\_rank::scorePopup( 0-bonusPointsRequired, 0, (1,0,0), 1 );
                player thread AImod\_Mod::TextPopup( nameofItem + "!" );
                player thread KillStreakRandom();
                wait 1;
            }
            else
            {
                player iPrintln("^1Not enough ^5Bonus Points^1 for " + nameofItem + " Need ^5" + bonusPointsRequired + "^1!");
                wait 1;
            }

        }
        wait 0.05;
    }
}

KillStreakRandom()
{
    self endon("disconnect");
    switch(randomInt(4))
    {
        case 0: Announcement(self.name + " Bought ^3Predator Missile!");
        self maps\mp\killstreaks\_killstreaks::giveKillstreak( "predator_missile", true );
        self maps\mp\gametypes\_hud_message::killstreakSplashNotify( "predator_missile_pickup");
        break;
        case 1: Announcement(self.name + " Bought an ^3Airstrike");
        self maps\mp\killstreaks\_killstreaks::giveKillstreak( "uav", true );
        wait 3.0;
        self maps\mp\gametypes\_hud_message::killstreakSplashNotify( "airstrike");
        break;
        case 2:
        Announcement(self.name + " Bought a Super Airstrike");
        self maps\mp\killstreaks\_killstreaks::giveKillstreak( "counter_uav", true );
        wait 3.0;
        self maps\mp\gametypes\_hud_message::killstreakSplashNotify( "ac130");
        break;
        case 3:
        Announcement(self.name + " Bought a Sentry Gun");
        self maps\mp\killstreaks\_killstreaks::giveKillstreak( "sentry", true );
        wait 3.0;
        self maps\mp\gametypes\_hud_message::killstreakSplashNotify( "sentry");
        break;
    }
}

UpgradeBoxFunction(pos, angle, powerIsRequired, cashAmountRequired, nameofItem)
{
    level endon("game_ended");
    
    self.trigger = Spawn( "trigger_radius", self.origin, 0, 50, 72 );
    self makeTeamUsable( "allies" );
    self useTriggerRequireLookAt();
    self SetCursorHint( "HINT_NOICON" );
    self SetHintString( "Requires Electricity!" );
    level waittill("power_activated");
    self SetHintString( "Press & hold ^3[{+activate}]^7 to use Pack-a-Punch Machine. [Cost: ^2$^35000^7]" );

    while(1)
    {
        self.trigger waittill( "trigger", player );
        
        team = player.team;
        if( team == "allies" )
            isAllies = true;
        else
            isAllies = false;

        if( isAllies && player UseButtonPressed() )
        {
            if( player.money >= cashAmountRequired )
            {
                player.gun = player getCurrentWeapon();
                player.gunup = player.gun;
                if ( IsDefined(level.upgrade_weapon[player.gunup])==1 )
                {
                    player playLocalSound( "mp_enemy_obj_captured" );
                    player.money -= cashAmountRequired;
                    player notify("MONEY");
                    player thread maps\mp\gametypes\_rank::scorePopup( 0-cashAmountRequired, 0, (1,0,0), 1 );
                    player thread AImod\_Mod::TextPopup( nameofItem + "!" );
                    level.upgradeweapon = spawn("script_model", player.origin+(0,0,50));
                    if(player.gunup == "pp2000_eotech_mp")
                        level.upgradeweapon setModel(GetWeaponModel(player.gunup, 6));
                    else if(player.gunup == "tmp_silencer_mp")
                        level.upgradeweapon setModel(GetWeaponModel(player.gunup, 8));
                    else
                        level.upgradeweapon setModel(GetWeaponModel(player.gunup, 0));
                    level.upgradeweapon.angles = angle;
                    level.upgradeweapon thread HideGunParts(player.gunup);
                    player takeWeapon(player getCurrentWeapon());
                    //Switch weapon back
                    wait 0.4;
                    level.upgradeweapon MoveTo(pos+(0,0,10), 2);
                    wait 2;
                    level.upgradeweapon delete();
                    player maps\mp\gametypes\Upgrade::giveUpgradedWeapon(pos, angle, player.gunup);
                    wait 1;
                }
                else
                {
                    player iPrintln("^1You current weapon can not be upgrade!");
                    wait 1;
                }
            }
            else
            {
                player iPrintln("^1Not enough cash for " + nameofItem + " Need $" + cashAmountRequired + "!");
                wait 1;
            }
        }
        wait 0.05;
    }
}

GamblerBoxFunction(pos,  bonusPointsRequired, nameofItem, laptop)
{
    level endon("game_ended");
    
    self.trigger = Spawn( "trigger_radius", self.origin, 0, 50, 72 );
    self makeTeamUsable( "allies" );
    self useTriggerRequireLookAt();
    self SetCursorHint( "HINT_NOICON" );
    self SetHintString( "Press & hold ^3[{+activate}]^7 to gamble. [Cost: ^520 ^7Points]" );

    while(1)
    {
        self.trigger waittill( "trigger", player );
        
        team = player.team;
        if( team == "allies" )
            isAllies = true;
        else
            isAllies = false;

        if( isAllies && player UseButtonPressed() )
        {
            if( player.bonus >= bonusPointsRequired )
            {
                if( player.gambler == 0 )
                {
                    player.bonus -= bonusPointsRequired;
                	  player notify("BONUS");
                    player thread maps\mp\gametypes\_rank::scorePopup( 0-bonusPointsRequired, 0, (1,0,0), 1 );
                	  player thread AImod\_Mod::TextPopup( nameofItem + "!" );
                    player.gambler = 1;
                    laptop MoveTo(laptop.origin+(0,0,30), 2);
                    player IPrintLnBold(" ^2Your result will show in 10 seconds");
                    wait 1;
                    for( i =  9; i > 0; i--)
                    {
                        player IPrintLnBold("^2" + i );
                        
                        if( i == 3 )
                            laptop MoveTo(laptop.origin-(0,0,30), 2);
                        
                        wait 1;
                    }
                    //if(level.mode_doa == 0)
											player thread MoneyGambler();
                    //else
                    	//player thread ChaosModeGambler();
                    wait 1;
                }
                else
                {
                    player iPrintln("^1You cannot buy the " + nameofItem + " until next round!");
                    wait 1;
                }
            }
            else
            {
                player iPrintln("^1Not enough ^5Bonus Points^1 for " + nameofItem + " Need " + bonusPointsRequired + "!");
                wait 1;
            }

        }
        wait 0.05;
    }
}

AmmoBoxFunction(pos, cashAmountRequired, nameofItem)
{
    level endon("game_ended");
    
    self.trigger = Spawn( "trigger_radius", self.origin, 0, 50, 72 );
    self makeTeamUsable( "allies" );
    self useTriggerRequireLookAt();
    self SetCursorHint( "HINT_NOICON" );
    self SetHintString( "Press & hold ^3[{+activate}]^7 to buy ammo. [Cost: ^2$^35000^7]" );

    while(1)
    {
        self.trigger waittill( "trigger", player );
        
        team = player.team;
        if( team == "allies" )
            isAllies = true;
        else
            isAllies = false;

        if( isAllies && player UseButtonPressed() )
        {
            if( player.money >= cashAmountRequired )
            {
                player ClearLowerMessage("activate", 1);
                player.money -= cashAmountRequired;
                player notify("MONEY");
                player thread maps\mp\gametypes\_rank::scorePopup( 0-cashAmountRequired, 0, (1,0,0), 1 );
                player thread AImod\_Mod::TextPopup( nameofItem + "!" );
                weaponList = player GetWeaponsListAll();
                foreach ( weaponName in weaponList )
                {
                    player giveMaxAmmo( weaponName );
                    player setweaponammoclip("semtex_mp", 3);
                }
                player playLocalSound( "ammo_crate_use" );
                wait 1;
            }
            else
            {
                player iPrintln("^1Not enough cash for " + nameofItem + " Need $" + cashAmountRequired + "!");
                wait 1;
            }

        }
        wait 0.05;
    }
}

MusicPlayerBox(pos, angle)
{
    block = spawn("script_model", pos );
    block setModel("com_plasticcase_enemy");
    block.angles = angle;
    block Solid();
    block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
    item = spawn("script_model", pos+(0,0,20) );
    item setModel("com_cellphone_on");
    item.angles = angle;
    item Solid();
    level.radiobox = item;
    block thread BoxShader("cardicon_harrier");
    curObjID = maps\mp\gametypes\_gameobjects::getNextObjID();
    objective_add( curObjID, "invisible", (0,0,0) );
    objective_position( curObjID, block.origin );
    objective_state( curObjID, "active" );
    objective_team( curObjID, "allies" );
    objective_icon( curObjID, "cardicon_harrier" );
    block thread MusicplayerBoxThink(pos);
    wait 0.05;
}

MusicPlayerBoxThink(pos, angle)
{
    level endon("game_ended");
    
    self.trigger = Spawn( "trigger_radius", self.origin, 0, 50, 72 );
    self makeTeamUsable( "allies" );
    self useTriggerRequireLookAt();
    self SetCursorHint( "HINT_NOICON" );
    self SetHintString( "Press & hold ^3[{+activate}]^7 to play a song." );

    for(;;)
    {
        self.trigger waittill( "trigger", player );

        team = player.team;
        if( team == "allies" )
            isAllies = true;
        else
            isAllies = false;
            

        if( isAllies && player UseButtonPressed() && !level.in_music )
        {
            player openpopupMenu(game["menu_music_player"]);
            level.curr_song = player MusicResponse();
            
            if( isDefined( level.curr_song ) )
                thread MusicPlayerPlaySong( self );
            wait 1;
        }
        wait 0.05;
    }
}

MusicPlayerPlaySong( box )
{
    box SetHintString( "^1Music is already playing!" );
    level.in_music = true;

    MusicPlay( level.curr_song.song, true, true );
    wait level.curr_song.length;
    MusicStop(1);
    level.in_music = false;
    box SetHintString( "Press & hold ^3[{+activate}]^7 to play a song." );
    level.curr_song = undefined;
    level notify("musicplayer_finished");
}


MusicResponse()
{
    self endon("disconnect");
    
    self waittill( "menuresponse", menu, response );
    
    if( menu != game["menu_music_player"] )
        return self MusicResponse();
        
    self closepopupMenu();
    self closeInGameMenu();
        
    if( response == "close" )
        return undefined;
    
    if( !isDefined( level.music[ response ] ) )
        return undefined;
            
    return level.music[ response ];
}

Power3(pos, angle)
{
    level endon("power_activated");
    block = spawn("script_model", pos );
    block setModel("com_plasticcase_friendly");
    block.angles = angle;
    block Solid();
    level.power = false;
    block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
    block.headIcon = newHudElem();
    block.headIcon.x = block.origin[0];
    block.headIcon.y = block.origin[1];
    block.headIcon.z = block.origin[2] + 50;
    block.headIcon.alpha = 0.85;
    block.headIcon setShader( "cardicon_bulb", 10,10 );
    block.headIcon setWaypoint( true, true, false );
    block thread Power3Think(pos, angle);
}

Power3Think(pos, angle)
{
    self endon("disconnect");
    level endon("power_activated_end");

    self.trigger = Spawn( "trigger_radius", self.origin, 0, 50, 72 );
    self makeTeamUsable( "allies" );
    self useTriggerRequireLookAt();
    self SetCursorHint( "HINT_NOICON" );
    self SetHintString( "Press & hold ^3[{+activate}]^7 to activate the electricity. [Cost: ^2$^310000^7]" );

    while(1)
    {
        self.trigger waittill( "trigger", player );
        
        team = player.team;
        if( team == "allies" )
            isAllies = true;
        else
            isAllies = false;

        if( isAllies && player UseButtonPressed() )
        {
            if( player.money >= 10000 )
            {
                player.money -= 10000;
                player notify("MONEY");
                self moveTo(self.origin+(0,0,1000), 2.3);
            
                wait 2.3;
            
                player thread EmpEffect(self);
                player thread maps\mp\gametypes\_rank::scorePopup( -10000, 0, (1,0,0), 1 );
                level.playername = player.name;
            
                foreach(player in level.players)
                {
                    player playLocalSound("mp_killstreak_counteruav");
                    player thread AImod\_Mod::TextPopup( "Power!" );
                    player thread AImod\_Intro::WelcomeText(level.playername, "Activated Power", "", "", "", 1, (1,1,1), (1,0.5,0.3), 0.85, (1,1,1), (1,0.5,0.3), 0.85, (1,1,1), (0.3,0.9,0.9), 0.85, (1,1,1), (0.3,0.9,0.3), 0.85, (1,1,1), (0.3,0.9,0.9), 0.85);
                }

                level.power = true;
                level notify("power_activated");
                self.headIcon Destroy();
                self.trigger Delete();
                self Delete();

                wait 0.5;
                if( !level.is_dedicated_server )
                {
                    foreach(player in level.players)
                    {
                        player playLocalSound( "nuke_explosion" );
                        Earthquake( 0.4, 1, player.origin, 100 );
                        player setClientDvar("ui_power", 1);
                    }
                }
                level notify("power_activated_end");
            }
        }
        wait 0.05;
    }
}

getBoxString( nameOfItem )
{
    triggerString = undefined;
    switch( nameofItem )
    {
        case "Quick Revive":
            triggerString = "Press & hold ^3[{+activate}]^7 to buy Quick Revive. [Cost: ^2$^31500^7]";
            break;
        case "Speed Cola":
            triggerString = "Press & hold ^3[{+activate}]^7 to buy Speed Cola. [Cost: ^2$^33000^7]";
            break;
        case "Juggernog":
            triggerString = "Press & hold ^3[{+activate}]^7 to buy Juggernog. [Cost: ^2$^32500^7]";
            break;
        case "Stamin-Up":
            triggerString = "Press & hold ^3[{+activate}]^7 to buy Stamin-Up. [Cost: ^2$^32000^7]";
            break;
        case "Double Tap Root Beer":
            triggerString = "Press & hold ^3[{+activate}]^7 to buy Double Tap Root Beer. [Cost: ^2$^32000^7]";
            break;
        case "Mule Kick":
            triggerString = "Press & hold ^3[{+activate}]^7 to buy Mule Kick. [Cost: ^2$^34000^7]";
            break;
        case "Deadshot Daiquiri":
            triggerString = "Press & hold ^3[{+activate}]^7 to buy Deadshot Daiquiri. [Cost: ^2$^31500^7]";
            break;
        case "PhD Flopper":
            triggerString = "Press & hold ^3[{+activate}]^7 to buy PhD Flopper. [Cost: ^2$^31500^7]";
            break;
        case "Tombstone Soda":
            triggerString = "Press & hold ^3[{+activate}]^7 to buy Tombstone Soda. [Cost: ^2$^32000^7]";
            break;
        case "Who's who":
            triggerString = "Press & hold ^3[{+activate}]^7 to buy Who's who. [Cost: ^2$^32000^7]";
            break;
        case "Electric Cherry":
            triggerString = "Press & hold ^3[{+activate}]^7 to buy Electric Cherry. [Cost: ^2$^32000^7]";
            break;
        case "Vulture Aid":
            triggerString = "Press & hold ^3[{+activate}]^7 to buy  Vulture Aid. [Cost: ^2$^33000^7]";
            break;
    }
    return triggerString;
}

getPerkMaterial( perk )
{
    return tableLookUp( "mp/perkTable.csv", 1, perk, 3 );
}

getPerkString( perk )
{
    return tableLookUpIString( "mp/perkTable.csv", 1, perk, 2 );
}

getPerkUpgraded( perk )
{
    return tablelookup( "mp/perktable.csv", 1, perk, 8 );
}

MoneyGambler()
{
    self endon("disconnect");

    switch(randomInt(13))
    {
        case 0:
        self thread GamblerText("You won $500!", (1,1,1), (0.3,0.9,0.3), 1, 0.85);
        self.money += 500;
        self thread Money();
        self notify("MONEY");
        break;
        case 1:
        self thread GamblerText("You won $1000!", (1,1,1), (0.3,0.9,0.3), 1, 0.85);
        self.money += 1000;
        self thread Money();
        self notify("MONEY");
        break;
        case 2:
        self thread GamblerText("You lost $1000", (1,1,1), (0.9,0.3,0.3), 1, 0.85);
        self.money -= 1000;
        self notify("MONEY");
        break;
        case 3:
        self thread GamblerText("You won $2000", (1,1,1), (0.3,0.9,0.3), 1, 0.85);
        self.money += 2000;
        self thread Money();
        self notify("MONEY");
        break;
        case 4:
        self thread GamblerText("You lose $500", (1,1,1), (0.3,0.9,0.3), 1, 0.85);
        self.money -= 500;
        self thread Money();
        self notify("MONEY");
        break;
        case 5:
        self thread GamblerText("You won $10000", (1,1,1), (0.3,0.9,0.3), 1, 0.85);
        self.money += 10000;
        self thread Money();
        self notify("MONEY");
        break;
        case 6:
        self thread GamblerText("You lost all cash!", (1,1,1), (0.9,0.3,0.3), 1, 0.85);
        self.money = 0;
        self notify("MONEY");
        break;
        case 7:
        self thread GamblerText("You lost $500!", (1,1,1), (0.9,0.3,0.3), 1, 0.85);
        self.money -= 500;
        self notify("MONEY");
        break;
        case 8:
        self thread GamblerText("You will Live or Die in 5 seconds", (1,1,1), (0.9,0.5,0.2), 1, 0.85);
        for( i = 5; i > 0; i--)
        {
            self IPrintLnBold("^1" + i );
            wait 1;
        }
        self thread Die();
        break;
        case 9:
        self thread GamblerText("You won a random perk", (1,1,1), (0.3,0.9,0.3), 1, 0.85);
        self thread RandomPerk();
				break;
        case 10:
        self thread GamblerText("You won max ammo", (1,1,1), (0.3,0.9,0.3), 1, 0.85);
        weaponList = self GetWeaponsListAll();
        foreach ( weaponName in weaponList )
        {
        	self giveMaxAmmo( weaponName );
          self setweaponammoclip("semtex_mp", 3);
        }
        break;
        case 11:
        self thread GamblerText("You lost you tombstone (if you have)!", (1,1,1), (0.9,0.3,0.3), 1, 0.85);
        if(self.tombstone == 1)
        {
        		self.tombstone = 0;
        		self.tombstone_weapons = [];
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
    		
    			self.tombstonehud destroy();
        }
			break;
        default:
        self thread GamblerText("You won nothing", (1,1,1), (0.9,0.3,0.3), 1, 0.85);
        break;
    }
}

/*
ChaosModeGambler()
{
}
*/

Money()
{
    level._effect["money"] = loadfx ("props/cash_player_drop");
    PlayFx(level._effect["money"],self.origin);
}

Die()
{
    switch(randomInt(4))
    {
        case 0: self suicide();
        break;
        default:
        self thread GamblerText("You Live", (1,1,1), (0.3,0.9,0.9), 1, 0.85);
        break;
    }
}


RandomPerk()
{
		self endon("disconnect");

		randomPerks = [];
		if(self.autorevive == 0) randomPerks[randomPerks.size]="Quick Revive";
		if(self.speedy == 0) randomPerks[randomPerks.size]="Stamin-Up";
		if(self.speedreload == 0) randomPerks[randomPerks.size]="Speed Cola";
		if(self.stoppingpower == 0) randomPerks[randomPerks.size]="Double Tap Root Beer";
		if(self.juggernaut == 0) randomPerks[randomPerks.size]="Juggernog";
		if(self.mulekick == 0) randomPerks[randomPerks.size]="Mule Kick";
		if(self.deadshot == 0) randomPerks[randomPerks.size]="Deadshot Daiquiri";
		if(self.phd == 0) randomPerks[randomPerks.size]="PhD Flopper";
		if(self.tombstone == 0) randomPerks[randomPerks.size]="Tombstone Soda";
		
		if(randomPerks.size > 0)
		{
				GiveRandomPerk(randomPerks[randomInt(randomPerks.size)]);
		}
}

GiveRandomPerk(perkName)
{
		switch(perkName)
		{
				case "Quick Revive":
				self.autorevive = 1;
				self thread PerkBoxHud( "specialty_pistoldeath_upgrade", (0,1,1), "Quick Revive" );
				break;
				case "Stamin-Up":
				self.speedy = 1;
				self thread PerkBoxHud("specialty_lightweight_upgrade", (0.9,0.9,0.3), "Stamin-Up");
				self _setPerk("specialty_marathon");
        		self _setPerk("specialty_lightweight");
        		self _setPerk("specialty_fastsprintrecovery");
				break;
				case "Double Tap Root Beer":
				self.juggernaut = 1;
				self thread PerkBoxHud("cardicon_juggernaut_2", (1,0.3,0.3), "Double Tap II");
				self.maxhealth = 200;
				break;
				case "Speed Cola":
				self.speedreload = 1;
				self thread PerkBoxHud("specialty_fastreload_upgrade", (0.3,0.9,0.3), "Speed Cola");
				self _setPerk("specialty_fastreload");
        		self _setPerk("specialty_quickdraw");
				break;
				case "Juggernog":
				self.juggernaut = 1;
				self thread PerkBoxHud("cardicon_juggernaut_2", (1,0.3,0.3), "Juggernog");
				self.maxhealth = 200;
				break;
				case "Mule Kick":
				self.mulekick = 1;
				self thread PerkBoxHud("cardicon_expert_aug", (0.9,0.9,0.3), "Mule Kick");
				break;
				case "Deadshot Daiquiri":
				self.deadshot = 1;
				self thread PerkBoxHud("cardicon_expert_fn2000", (0.1,0.1,0.1), "Deadshot Daiquiri");
				self _setPerk("specialty_bulletaccuracy");
				self _setPerk("specialty_steelnerves");
				break;
				case "PhD Flopper":
				self.phd = 1;
				self thread PerkBoxHud("cardicon_expert_kriss", (0.7,0.5,1), "PhD!");
				break;
				case "Tombstone Soda":
				self.tombstone = 1;
				self thread PerkBoxHud("cardicon_expert_m21", (1,1,0.7), "Tombstone");
				break;
		}
}

TakePerks()
{
    if ( self _hasPerk( "specialty_finalstand" ) )
    {
        self _ClearPerks();
        self maps\mp\perks\_perks::givePerk( "specialty_finalstand" );
    }
    else
    {
        self _ClearPerks();
    }
    self.autorevive = 0;
	self.speedy = 0;
	self.stalker = 0;
	self.mulekick = 0;
	self.mulekicktakeweapon = "";
	self.speedreload = 0;
	self.stoppingpower = 0;
	self.juggernaut = 0;
	self.deadshot = 0;
	self.phd = 0;
	self.whoswho = 0;
	self.cherry = 0;
	self.aid = 0;
    self.maxhealth = 100;
    self.health = self.maxhealth;
    self.ammomatic = 0;
    self.extra = 1;
    self.zombieperks = 0;
    self thread AImod\_Mod::DestoyPerkHud();
    //self.money -= 200;
}

rotateLaptop()
{
    for(;;)
    {
        self rotateyaw(-360,7);
        wait 7;
    }
}

setHPOverlay( color )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "unset_combathigh" );
    level endon( "end_game" );

    self.combatHighOverlay destroy();

    self.combatHighOverlay = newClientHudElem( self );
    self.combatHighOverlay.x = 0;
    self.combatHighOverlay.y = 0;
    self.combatHighOverlay.alignX = "left";
    self.combatHighOverlay.alignY = "top";
    self.combatHighOverlay.horzAlign = "fullscreen";
    self.combatHighOverlay.vertAlign = "fullscreen";
    self.combatHighOverlay setshader ( "combathigh_overlay", 640, 480 );
    
    if( isDefined( color ) )
        self.combatHighOverlay.color = color;
    
    self.combatHighOverlay.sort = -10;
    self.combatHighOverlay.archived = true;

    self.combatHighOverlay.alpha = 0.0;
    self.combatHighOverlay fadeOverTime( 1.0 );
    self.combatHighIcon fadeOverTime( 1.0 );
    self.combatHighOverlay.alpha = 1.0;
    self.combatHighIcon.alpha = 0.85;
    
    self thread maps\mp\perks\_perkfunctions::unsetCombatHighOnDeath();
    
    wait 30;
    
    self.combatHighOverlay fadeOverTime( 2.0 );
    self.combatHighOverlay.alpha = 0.0;

    wait 1;
 
    self.combatHighOverlay destroy();
}


InitTombstone()
{
		self.tombstone_speedcola = self.speedreload;
		self.tombstone_jugger = self.juggernaut;
		self.tombstone_speedy = self.speedy;
		self.tombstone_mulekick = self.mulekick;
		self.tombstone_mulekickweapon = self.mulekicktakeweapon;
		self.tombstone_doubletap = self.stoppingpower;
		self.tombstone_deadshot = self.deadshot;
		self.tombstone_phd = self.phd;
		self.tombstone_whoswho = self.whoswho;
		self.tombstone_cherry = self.cherry;
		self.tombstone_aid = self.aid;
		
		self thread CreateTombstone();
		self thread TombstoneRevived();
}

CreateTombstone()
{
		self endon("disconnect");
		self endon("tombstone_spawned");

		self waittill("death");
		precachemodel("weapon_oma_pack_in_hand");
		tombstoneent = spawn("script_model", self.origin + (0, 0, 45) );
		tombstoneent setmodel("weapon_oma_pack_in_hand");
		tombstoneent.fx = SpawnFX(loadfx("fire/firelp_small_pm"),level.tombstone.origin);
		TriggerFX(tombstoneent.fx);
		tombstoneent thread AImod\_DoaBonusDrops::rotateDrop("tombstone_destroy");
		tombstoneent.trigger = spawn( "trigger_radius", self getOrigin(), 0, 75, 50 );
		tombstoneent.owenr = self;
		
		wait 3;
		tombstoneent thread TombstoneThink();
		tombstoneent thread TombstoneDestroy();
				
		self notify("tombstone_spawned");
}

TombstoneThink()
{		
		level endon ("clear_tombstones");	
	
		while(1)
		{
				self.trigger waittill( "trigger", player );
				if(player.name == self.owenr.name)
				{
						player thread AImod\_text::BonusDropText("Tombstone!", 0.85, (1,1,1),(1,0.3,0.3),1);
						player thread AImod\_text::BonusDropIcon("cardicon_expert_m21");
						player playlocalsound( "mp_killstreak_carepackage" );
						
						player thread UseTombstone();
						
						wait 0.1;
						self notify ("tombstone_destroy");
    					self.trigger delete();
    					self.fx delete();
    					self delete();
				}
		}
}

TombstoneRevived()
{
		self endon ("disconnect");
		
		self waittill("revive");
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
}

TombstoneDestroy()
{
	level waittill("clear_tombstones");
	
	player = self.owenr;

  	player.tombstone_speedcola = 0;
  	player.tombstone_jugger = 0;
  	player.tombstone_speedy = 0;
  	player.tombstone_mulekick = 0;
  	player.tombstone_mulekickweapon = "";
  	player.tombstone_doubletap = 0;
	player.tombstone_deadshot = 0;
 	player.tombstone_phd = 0;
    player.tombstone_whoswho = 0;
    player.tombstone_cherry = 0;
    player.tombstone_aid = 0;
    
    player.tombstonehud destroy();
    
    self notify ("tombstone_destroy");
    self.trigger delete();
    self.fx delete();
    self delete();
}

UseTombstone()
{
		if(self.tombstone_speedcola >= 1)
		{
				self.speedreload = 1;
				self.zombieperks += 1;
				self thread PerkHudNoEffect("specialty_fastreload_upgrade");
				self _setPerk("specialty_fastreload");
        		self _setPerk("specialty_quickdraw");
		}
		if(self.tombstone_jugger >= 1)
		{
				self.juggernaut = 1;
				self.zombieperks += 1;
				self thread PerkHudNoEffect("cardicon_juggernaut_2");
				self.maxhealth = 200;
		}
		if(self.tombstone_speedy >= 1)
		{
				self.speedy = 1;
				self.zombieperks += 1;
				self thread PerkHudNoEffect("specialty_lightweight_upgrade");
				self _setPerk("specialty_marathon");
        		self _setPerk("specialty_lightweight");
        		self _setPerk("specialty_fastsprintrecovery");
		}
		if(self.tombstone_mulekick >= 1)
		{
				self.mulekick = 1;
				self.zombieperks += 1;
				self thread PerkHudNoEffect("cardicon_expert_aug");
		}
		if(self.tombstone_doubletap >= 1)
		{
				self.stoppingpower = 1;
				self.zombieperks += 1;
				self thread PerkHudNoEffect("cardicon_doubletap");
				self _setPerk("specialty_rof");
		}
		if(self.tombstone_deadshot >= 1)
		{
				self.deadshot = 1;
				self.zombieperks += 1;
				self thread PerkHudNoEffect("cardicon_expert_fn2000");
				self _setPerk("specialty_bulletaccuracy");
				self _setPerk("specialty_steelnerves");
		}
		if(self.tombstone_phd >= 1)
		{
				self.phd = 1;
				self.zombieperks += 1;
				self thread PerkHudNoEffect("cardicon_expert_kriss");
		}
		
		wait 1;
		self takeallweapons();
		self thread LoadPlayerWeapons();
		wait 0.1;
		self switchToWeapon(self.tempweapon);
		if(self.tombstone_mulekick == 1 && self.tombstone_mulekickweapon != "")
		{
			self GiveWeapon(self.tombstone_mulekickweapon);
			self givemaxammo (self.tombstone_mulekickweapon);
			self.mulekicktakeweapon = self.tombstone_mulekickweapon;
		}
		self giveWeapon("semtex_mp");
		self setweaponammoclip("semtex_mp", 3);
		

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
		
		self.tombstonehud destroy();
}