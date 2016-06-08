#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include AImod\_OtherFunctions;

IntermissionCountdown()
{
	level endon("disconnect");
	level waittill("start_zombie_round");
	
	for(count = level.IntermissionTimeStart;count > -1;count--)
	{
		wait 1;
		level.IntermissionTime = count;
	}
	wait 1;
	AImod\_Bot::setupCompass( 8 ); //Argument defines how many zombies get displayed on the compass!
	wait 1;
	level.activeUAVs["allies"]++;	
	level notify("uav_update");
	//TODO: add timer [Intermission Time]
	for(i=0;i < level.MaxWaves;i++)
	{
		level thread AImod\_Bot::BotMain();
		level waittill("round_ended");

		for( i = level.IntermissionTimeRound; i >= 0; i-- )
		{
			level.IntermissionTime = i;
			wait ( 1.0 );
		}
		
		wait ( 1.0 );
	}
}

UpdateZombies(player)
{
	player endon("death");
	while(1)
	{
		if(AImod\_botUtil::ZombieCount() < 1)
		{
			self.color = (0.3,0.9,0.3);
			self setValue(AImod\_botUtil::ZombieCount());
		}
		else if(AImod\_botUtil::ZombieCount() <= 5)
		{
			self.color = (0.9,0.9,0.3);
			self setValue(AImod\_botUtil::ZombieCount());
		}
		else
		{
			self.color = (1,0.5,0.2);
			self setValue(AImod\_botUtil::ZombieCount());
		}
		level waittill_either("zombie_spawned", "zombie_died");
	}
}

IntermissionHud()
{
	self endon("disconnect");
	self.intermissionTimer[0] = self createFontString( "objective", 1.2 );
	self.intermissionTimer[0] setPoint( "TOPLEFT", "TOPLEFT", 13, 130);
	self.intermissionTimer[0].color = (1,1,1);
	self.intermissionTimer[0].glowColor = (0.3, 0.9, 0.9);
	self.intermissionTimer[0].glowAlpha = 0.75;
	self.intermissionTimer[0].alpha = 1;
	while(1)
	{
		if(level.IntermissionTime > 0)
		{
			self.intermissionTimer[0].label = &"Next Round In: ";
			self.intermissionTimer[0] fadeOverTime( 1.00 );
			self.intermissionTimer[0].alpha = 1;
			self.intermissionTimer[0] setValue(level.IntermissionTime);
				
		}
		else
		{
			self.intermissionTimer[0] fadeOverTime( 1.00 );
			self.intermissionTimer[0].alpha = 0;
		}
		wait 0.9;
	}
}

PerkHud( shader, color, text )
{
	self setblurforplayer( 6, 0.5 );
	perksAmount = self.zombieperks - 1;
	MultiplyTimes = 28 * perksAmount;
	self.perktext[shader] = NewClientHudElem( self );
	self.perktext[shader].alignX = "center";
	self.perktext[shader].vertAlign = "middle";
	self.perktext[shader].alignY = "middle";
	self.perktext[shader].horzAlign = "center";
	self.perktext[shader].font = "objective";
	self.perktext[shader].fontscale = 1.5;
	self.perktext[shader].x = 0;
	self.perktext[shader].y = 0;
	self.perktext[shader].foreground = true;
	self.perktext[shader].color = color;
	self.perktext[shader].alpha = 0;
	self.perktext[shader] setText(text);
	self.perkhud[shader] = NewClientHudElem( self );
	self.perkhud[shader].alignX = "center";
	self.perkhud[shader].vertAlign = "middle";
	self.perkhud[shader].alignY = "middle";
	self.perkhud[shader].horzAlign = "center";
	self.perkhud[shader].x = 0;
	self.perkhud[shader].y = 0;
	self.perkhud[shader].foreground = true;
	self.perkhud[shader] setIconShader( shader );
	self.perkhud[shader] setIconSize( 30, 30 );
	self.perkhud[shader].alpha = 1;
	wait 0.3;
	self.perktext[shader].alpha = 0;
	self.perkhud[shader] moveOverTime( 0.50 );
	self.perkhud[shader].x = -200;
	self.perkhud[shader].y = 0;
	wait 0.50;
	self setblurforplayer( 0, 0.3 );
	self.perktext[shader].alpha = 1;
	wait 3;
	self.perktext[shader] fadeOverTime(0.25);
	self.perktext[shader].alpha = 0;
	self.perkhud[shader] scaleOverTime( 1, 25, 25 );
	self.perkhud[shader] moveOverTime( 1 );
	self.perkhud[shader].x = -410 + MultiplyTimes;
	self.perkhud[shader].y = 187;
	wait 1;
	self.perktext[shader] destroy();
}

PerkHudNoEffect( shader )
{
	perksAmount = self.zombieperks - 1;
	MultiplyTimes = 28 * perksAmount;
	self.perkhud[shader] = NewClientHudElem( self );
	self.perkhud[shader].alignX = "center";
	self.perkhud[shader].vertAlign = "middle";
	self.perkhud[shader].alignY = "middle";
	self.perkhud[shader].horzAlign = "center";
	self.perkhud[shader].x = -410 + MultiplyTimes;
	self.perkhud[shader].y = 187;
	self.perkhud[shader].foreground = true;
	self.perkhud[shader] setIconShader( shader );
	self.perkhud[shader] setIconSize( 25, 25 );
	self.perkhud[shader].alpha = 1;
}

PerkTombstoneHud(shader, color, text)
{
	self setblurforplayer( 6, 0.5 );
	self.tombstonehudtext = NewClientHudElem( self );
	self.tombstonehudtext.alignX = "center";
	self.tombstonehudtext.vertAlign = "middle"; 
	self.tombstonehudtext.alignY = "middle";
	self.tombstonehudtext.horzAlign = "center";
	self.tombstonehudtext.font = "objective";
	self.tombstonehudtext.fontscale = 1.5;
	self.tombstonehudtext.x = 0;
	self.tombstonehudtext.y = 0;
	self.tombstonehudtext.foreground = true;
	self.tombstonehudtext.color = color;
	self.tombstonehudtext.alpha = 0;
	self.tombstonehudtext setText(text);
	self.tombstonehud = NewClientHudElem( self );
	self.tombstonehud.alignX = "center";
	self.tombstonehud.vertAlign = "middle";
	self.tombstonehud.alignY = "middle";
	self.tombstonehud.horzAlign = "center";
	self.tombstonehud.x = 0;
	self.tombstonehud.y = 0;
	self.tombstonehud.foreground = true;
	self.tombstonehud setIconShader( shader );
	self.tombstonehud setIconSize( 30, 30 );
	self.tombstonehud.alpha = 1;
	wait 0.3;
	self.tombstonehudtext.alpha = 0;
	self.tombstonehud moveOverTime( 0.50 );
	self.tombstonehud.x = 200;
	self.tombstonehud.y = 0;
	wait 0.50;
	self setblurforplayer( 0, 0.3 );
	self.tombstonehudtext.alpha = 1;
	wait 3;
	self.tombstonehudtext fadeOverTime(0.25);
	self.tombstonehudtext.alpha = 0;
	self.tombstonehud scaleOverTime( 1, 25, 25 );
	self.tombstonehud moveOverTime( 1 );
	self.tombstonehud.x = 390;
	self.tombstonehud.y = 217;
	wait 1;
	self.tombstonehudtext destroy();
}