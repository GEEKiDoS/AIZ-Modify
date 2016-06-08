#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include AImod\_OtherFunctions;

WaypointInit()
{
	/* This map is to small to have waypoints */
}

Init()
{
    level thread PrecacheContingency();
	level thread SpawnObjects();
}

PrecacheContingency()
{

}

Teleporter(pos, angle, end)
{
	while(level.Wave != 2)
		wait 1;
	level.teleporter[0] = spawn("script_model", pos+(0,0,1000) );
	level.teleporter[0] setModel("com_plasticcase_friendly");
	level.teleporter[0].angles = angle;
	level.teleporter[0] CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	level.teleporter[0] setContents(1);
	curObjID = maps\mp\gametypes\_gameobjects::getNextObjID();	
	objective_add( curObjID, "invisible", (0,0,0) );
	objective_position( curObjID, level.teleporter[0].origin-(0,0,1000) );
	objective_state( curObjID, "active" );
	objective_team( curObjID, "allies" );
	objective_icon( curObjID, "hudicon_neutral" );
	level.teleporter[0].trigger = spawn( "trigger_radius", pos, 0, 75, 50 );
	level.teleporter[0].trigger.angles = angle;
	level.teleporter[0].trigger thread TeleporterThink(pos, angle, end);
	level.teleporter[0] moveTo(level.teleporter[0].origin-(0,0,1000), 0.7);
	wait 0.7;
	playFx(loadfx("explosions/tanker_explosion"), level.teleporter[0].origin);
	level.teleporter[0] playSound("explo_mine");
	foreach(player in level.players)
	{
		Earthquake( 0.4, 1, player.origin, 100 );
	}
}

TeleporterThink(pos, angle, end)
{
	self endon("disconnect");
	while(1)
	{
		self waittill( "trigger", player );
		if(Distance(pos, Player.origin) <= 75 && level.power == 0)
		{
			Player setLowerMessage("activate", "Power needs to be activated" );
		}
		else if(Distance(pos, Player.origin) <= 75 && level.power == 1)
		{
			Player setLowerMessage("activate", "Hold ^3[{+activate}]^7 to use Teleporter [^2$^32000^7]" );
		}
		if(Distance(pos, Player.origin) > 50)
		{
			Player ClearLowerMessage("activate", 1);
		}
		if(Distance(pos, Player.origin) <= 75 && player.pers["team"] == "allies" && level.power == 0 && player useButtonPressed())
		{
			player iPrintln("^1Power needs to be activated!");
			wait 1;
		}
		else if(Distance(pos, Player.origin) <= 75 && player.money < 2000 && level.power == 1 && player useButtonPressed())
		{
			player ClearLowerMessage("activate", 1);
			player iPrintln("^1Not enough money for Teleporter need $2000!");
			wait 1;
		}
		else if(Distance(pos, Player.origin) <= 75 && player.pers["team"] == "allies" && player useButtonPressed())
		{
			player ClearLowerMessage("activate", 1);
			player.money -= 2000;
			player notify("MONEY");
			player ShellShock( "frag_grenade_mp", 3 );
			wait 2;
			player ShellShock( "concussion_grenade_mp", 3 );
			player thread AImod\_Mod::TextPopup( "Teleported!" );
			player.oldorigin = self.origin;
			player setorigin(end);
			player setplayerangles((0,146,0));
			player thread SpawnBack();
			level notify("boxend");
		}
		wait 0.01;
	}
}

TeleporterBonus(pos, angle, end)
{
	while(level.Wave != 5)
		wait 1;
	level.teleporter[1] = spawn("script_model", pos+(0,0,1000) );
	level.teleporter[1] setModel("com_plasticcase_friendly");
	level.teleporter[1].angles = angle;
	level.teleporter[1] CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	level.teleporter[1] setContents(1);
	curObjID = maps\mp\gametypes\_gameobjects::getNextObjID();	
	objective_add( curObjID, "invisible", (0,0,0) );
	objective_position( curObjID, level.teleporter[1].origin );
	objective_state( curObjID, "active" );
	objective_team( curObjID, "allies" );
	objective_icon( curObjID, "hudicon_neutral" );
	level.teleporter[1].trigger = spawn( "trigger_radius", pos, 0, 75, 50 );
	level.teleporter[1].trigger.angles = angle;
	level.teleporter[1] thread TeleporterBonusThink(pos, angle, end);
	level.teleporter[1] moveTo(level.teleporter[1].origin-(0,0,1000), 0.7);
	wait 0.7;
	playFx(loadfx("explosions/tanker_explosion"), level.teleporter[1].origin);
	level.teleporter[1] playSound("explo_mine");
	foreach(player in level.players)
	{
		Earthquake( 0.4, 1, player.origin, 100 );
	}
}

TeleporterBonusThink(pos, angle, end)
{
	self endon("disconnect");
	while(1)
	{
		self.trigger waittill( "trigger", player );
		if(Distance(pos, Player.origin) <= 75 && level.power == 0)
		{
			Player setLowerMessage("activate", "Power needs to be activated" );
		}
		else if(Distance(pos, Player.origin) <= 75 && level.power == 1)
		{
			Player setLowerMessage("activate", "Hold ^3[{+activate}]^7 to use Special Teleporter [^5Need 600 Bonus Points^7]" );
		}
		if(Distance(pos, Player.origin) > 50)
		{
			Player ClearLowerMessage("activate", 1);
		}
		if(Distance(pos, Player.origin) <= 75 && player.pers["team"] == "allies" && level.power == 0 && player useButtonPressed())
		{
			player iPrintln("^1Power needs to be activated!");
			wait 1;
		}
		else if(Distance(pos, Player.origin) <= 75 && player.bonus < 600 && level.power == 1 && player useButtonPressed())
		{
			player ClearLowerMessage("activate", 1);
			player iPrintln("^1Not enough money for Teleporter need 600 bonus points!");
			wait 1;
		}
		else if(Distance(pos, Player.origin) <= 75 && player.pers["team"] == "allies" && player useButtonPressed())
		{
			player ClearLowerMessage("activate", 1);
			player.bonus -= 600;
			player notify("BONUS");
			player ShellShock( "frag_grenade_mp", 3 );
			wait 2;
			playFx(loadfx("explosions/tanker_explosion"),player.origin);
			player playSound("explo_mine");
			player ShellShock( "concussion_grenade_mp", 3 );
			player thread AImod\_Mod::TextPopup( "Teleported!" );
			player.oldorigin = self.origin;
			player setorigin(end);
			player setplayerangles((0,176,0));
			player thread SpawnBackQuick();
			level notify("boxend");
			self delete();
		}
		wait 0.01;
	}
}

BonusDrop(pos, angle, text)
{
	level.specblock = spawn("script_model", pos + (0, 0, 45) );
	level.specblock setModel("weapon_ak47_tactical");
	level.specblock thread HideGunParts("ak47_fmj_mp");
	level.specblock.angles = angle;
	level.specblock.gun2 = spawn("script_model", pos + (0, 10, 45) );
	level.specblock.gun2 setModel("weapon_ak47_tactical");
	level.specblock.gun2 thread HideGunParts("ak47_fmj_mp");
	level.specblock.gun2.angles = angle;
	level.specblock.trigger = spawn( "trigger_radius", pos, 0, 75, 50 );
	level.specblock.trigger.angles = angle;
	level.specblock.fx = SpawnFX(loadFX("misc/flare_ambient"),level.specblock.origin);
	TriggerFX(level.specblock.fx);
	level.specblock thread BonusDropThink(pos, angle, text);
	level.specblock thread rotateDrop();
	level.specblock.gun2 thread rotateDrop();
	wait 0.01;
}

BonusDropThink(pos, angle, text)
{
	self endon("disconnect");
	while(1)
	{
		self.trigger waittill( "trigger", player );
		if(Distance(pos, Player.origin) <= 75)
		{
			player thread AImod\_text::BonusDropText(text + "!", 0.85, (1,1,1),(1,0.3,0.3),1); 
			player takeWeapon(player getCurrentWeapon());
			player giveWeapon("ak47_fmj_mp", 0, true);
			player switchToWeapon("ak47_fmj_mp");
			player GiveMaxAmmo("ak47_fmj_mp");
			if( !level.is_dedicated_server )
			{
				player playLocalSound("mp_killstreak_carepackage");
			}
			self delete();
			self.gun2 delete();
			self.fx delete();
			self.trigger delete();
		}
		wait 0.1;
	}
}

rotateDrop()
{
	while(self)
	{
		self rotateyaw(-360,5);
		wait 5;
	}
}

SpawnBack()
{
	self endon("death");
	wait 30;
	self ShellShock( "frag_grenade_mp", 3 );
	wait 2;
	self ShellShock( "concussion_grenade_mp", 3 );
	self thread AImod\spawn::change_spawns();
}

SpawnBackQuick()
{
	self endon("death");
	wait 20;
	self ShellShock( "frag_grenade_mp", 3 );
	wait 2;
	self ShellShock( "concussion_grenade_mp", 3 );
	self thread AImod\spawn::change_spawns();
}

SpawnObjects()
{
	Teleporter((-4653,1917,791),(0,142,0),(-6694,1054,1515));
	TeleporterBonus((-4276,2124,791),(0,233,0),(3048,-2323,651));
	BonusDrop((2676,-2329,644),(0,0,0),"Dual Wield AK-47's");
}