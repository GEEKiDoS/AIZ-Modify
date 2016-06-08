#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

/****************************/
/*     Code by momo5502     */
/****************************/

initDogs()
{
	supportedMap = [];
	
	supportedMap["contingency"] = 1;
	supportedMap["favela"] = 1;
	supportedMap["af_caves"] = 1;
	supportedMap["ending"] = 1;
	supportedMap["boneyard"] = 1;
	
	level.dogs = [];
	
	if(!isDefined( supportedMap[getDvar("mapname")] ) )
		return false;

	precacheModel("german_sheperd_dog");
	
	foreach( animation in getAnimList() )
	{
		precacheMpAnim(animation);
	}
	
	level thread watchDog(); //LOOOOOOL
}

watchDog()
{
	while( true )
	{
		level waittill("zombie_round_started_end");
		watchSpawn();
	}
}

watchSpawn()
{
	level endon("round_ended");
	level endon("wrong_wave");
	
	if( AImod\_Bot::getType( ) != "hell_normal" && AImod\_Bot::getType( ) != "normal_zombie" )
		level notify("wrong_wave");
	
	while( true )
	{
		rand = randomintrange( 5, 12 );
		
		for(i=0;i<rand;i++)
			level waittill("zombie_died");
			
		SpawnDog( AImod\_botUtil::GetMapSpawnPoint()+(randomIntRange(-20,20),randomIntRange(-20,20),0) );
	}
}

spawnDog( origin )
{
	level notify("zombie_spawned");
	pos = physicstrace( origin + (0,0,200), origin - (0,0,200));
	dog = spawn("script_model", pos);
	dog setModel("tag_origin");
	dog Hide();
	dog.type = "dog";
	dog.voice = "arab";
	dog.weapon = "dog_bite";
	dog.team = "axis";
	dog.targetname = "dog";
	dog.classname = "dog";
	dog.currentsurface = "default";
	dog.pers["isAlive"] = "true"; //Why bool as string?
	dog.isOnCompass = false;
	dog thread Spawn_Dog_Damage_Box();
	dog thread FollowPlayer();
	dog.id = level.dogs.size;
	level.dogs[level.dogs.size] = dog;
	return dog;
}

Spawn_Dog_Damage_Box()
{
	self.crate1 = spawn("script_model", self getTagOrigin( "tag_origin" ));
	self.crate1 setModel("com_plasticcase_beige_big");
	self.crate1 CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	self.crate1.angles = (0,0,0);
	self.crate1 Solid();
	self.crate1 hide();
	self.crate1.team = "axis";
	self.crate1 setCanDamage(true);
	self.crate1.maxhealth = level.ZombieHealths[ "hell_normal" ];
	self.crate1.health = level.ZombieHealths[ "hell_normal" ];
	self.crate1 linkto( self, "tag_origin" );
	
	self.dog = spawn("script_model", self getTagOrigin( "tag_origin" ));
	self.dog setModel("german_sheperd_dog");
	self.dog linkto( self, "tag_origin" );
	
	self thread DogHealth();
	self thread AImod\_Bot::KillIfUnderMap();
}

playAnim( animation )
{
	self scriptModelPlayAnim(animation);
	self scriptModelPlayAnim(animation); //Need to ensure anim really plays!
}

getListOfFollowablePlayers()
{
	players = [];
	
	foreach( player in level.players )
	{
		
		if(!isAlive(player))
               continue;

		if(level.teamBased && self.team == player.pers["team"])
            continue;
			
		if(player.team == "spectator")
			continue;
		
		if(player.sessionstate != "playing")
			continue;

		if(player.inLastStand == true)
			continue;
			
		if( !bulletTracePassed( self.origin+(0,0,75), player.origin+(0,0,65), false, self ) && !bulletTracePassed( player.origin+(0,0,65), self.origin+(0,0,75), false, player ) )
                continue;
			
		players[players.size] = player;
	}
	
	return players;
}

FollowPlayer()
{
	self endon("dieing");
	level endon("round_ended");
	
	for(;;)
	{
		players = getListOfFollowablePlayers();
		
		if( players.size == 0 )
		{
			self.angry = false;
			self Walk( false );
			wait 0.5;
			continue;
		}
		else
		{
			self.angry = true;
		}
		
		nearestp = players[0];
		
		foreach( player in players )
		{
			if( distance( self.origin, player.origin ) < distance( self.origin, nearestp.origin ) )
			{
				nearestp = player;
			}
		}
		if(distancesquared(nearestp.origin, self.origin) <= 2500 )
		{
			if( self.angry )
			{
				self.dog playAnim("german_shepherd_attack_player");
				self MoveTo( nearestp.origin, 1 );
				wait 1;
				self MoveTo( nearestp.origin, 0.5 );
				damage = 50;
				nearestp thread maps\mp\gametypes\_damage::finishPlayerDamageWrapper( self, self, damage, 0, "MOD_FALLING", "none", nearestp.origin, nearestp.origin, "none", 0, 0 );
				wait 2;
				//self.angry = false;
			}
			
			self Walk( false );
		}
			
		else
		{
			speed = 75;
			step = 50;
			if( self.angry )
			{
				speed = 200;
				step = 150;
			}
			self Walk( true );
			angles = VectorToAngles( nearestp.origin - self.origin);
			vect = Vector_multiply( AnglesToForward(angles), step ) + self.origin;
			pos = physicstrace( vect + (0,0,50), vect - (0,0,100)) ;
			self MoveTo( pos, distance( self.origin, pos ) / speed );
			self RotateTo( angles , 0.5 );
		}
		wait 0.5;
	}
}

DogHealth()
{
	level endon("round_ended");
	self endon("dieing");
	self thread killnotifier();
	self thread killDog();
	for(;;)
	{
		self.crate1 waittill("damage", iDamage, attacker, iDFlags, vPoint, type, victim, vDir, sHitLoc, psOffsetTime, sWeapon);		
		
		if( isDefined( attacker.type ) && attacker.type == "sentry" && isDefined( attacker.owner ) )
		{
			attacker = attacker.owner;
		}
		
		self thread DogHit(iDamage, attacker, iDFlags, vPoint, type, victim, vDir, sHitLoc, psOffsetTime, sWeapon);
		
		if( self.crate1.health <= 0 )
		{
			attacker thread AImod\_Bot::AttackerGain();
			self notify("dieing");
		}
	}
}

killnotifier()
{
	self endon("dieing");
	level waittill("round_ended");
	self notify("round_ended");
}

killDog()
{
	self waittill_any("round_ended", "dieing");
	{
		self.isWalking = false;
		self.dog playAnim("german_shepherd_death_front");
		self.pers["isAlive"] = "false";
		level.dogs[self.id] = undefined;
		level notify("zombie_died");
		self notify("bot_death");
		wait 5;
		self thread deleteAfter( 10 );
	}
}

DogHit(iDamage, attacker, iDFlags, vPoint, type, victim, vDir, sHitLoc, psOffsetTime, sWeapon)
{
	attacker thread maps\mp\gametypes\_damagefeedback::updateDamageFeedback(sHitLoc);
	{
		self notify("hit");
		if(level.insta_ko == 1)
		{
			self.crate1.health -= ( self.crate1.maxhealth + 1 );
		}
		//self.angry = true;
		self.crate1.health -= iDamage;
		playFx(level.bloodfx,vPoint);
		self AImod\_Bot::EarnMoney( 10 );
		self thread playPain();
	}
}

Walk( bool )
{
	if( !isDefined( self.isWalking ) )
	{
		self.dog playAnim("german_shepherd_idle");
		self.isWalking = false;
	}
		
	if( bool )
	{
		if( !self.isWalking )
		{
			if( self.angry)
			{
				self.dog playAnim("german_shepherd_run_start");
				wait 0.5;
				self.dog playAnim("german_shepherd_run");
				self thread randSound(true);
			}
			else
				self.dog playAnim("german_shepherd_walk");
				
			self.isWalking = true;
		}
	}
	else
	{
		if( self.isWalking )
		{
			self.isWalking = false;
			self MoveTo(self.origin, 0.1 );
			if( self.angry)
			{
				self.dog playAnim("german_shepherd_run_stop");
				wait 0.5;
				self.dog playAnim("german_shepherd_attackidle_bark");
			}
			else
				self.dog playAnim("german_shepherd_idle");
			
		}
	}
}

bark()
{
	while(!self.isWalking && self.angry)
	{
		self playsound("anml_dog_bark");
		wait( randomfloatrange( 1, 2 ) );
	}
}

playPain()
{
	self endon("dieing");
	if(!isDefined(self.paining))
		self.paining = false;
		
	if(self.paining)
		return;
		
	self.paining = true;
	self.dog playAnim("german_shepherd_run_pain");
	wait 1.6;
	self.dog playAnim("german_shepherd_run");
	self.paining = false;
	self thread randSound(true);
}

randSound(loop)
{
	self notify("soundplay");
	self endon("soundplay");
	
	if( randomint( 65535 ) % 2 == 1 )
			self playsound("anml_dog_growl");
		else
			self playsound("anml_dog_bark");
		wait( randomfloatrange( 1, 2 ) );
		
	while( self.isWalking && loop && self.angry)
	{
		if( randomint( 65535 ) % 2 == 1 )
			self playsound("anml_dog_growl");
		else
			self playsound("anml_dog_bark");
		wait( randomfloatrange( 1, 2 ) );
	}
}

deleteAfter( seconds )
{
	wait seconds;
	self.dog delete(); 
	self.crate1 delete();
	self delete();
}

getAnimList()
{
	doganim = [];
	prefix = "german_shepherd_";
	doganim[doganim.size] = prefix + "walk";
	doganim[doganim.size] = prefix + "idle";
	doganim[doganim.size] = prefix + "attack_player";
	doganim[doganim.size] = prefix + "death_front";
	doganim[doganim.size] = prefix + "run_pain";
	doganim[doganim.size] = prefix + "run_stop";
	doganim[doganim.size] = prefix + "run_attack";
	doganim[doganim.size] = prefix + "run";
	doganim[doganim.size] = prefix + "run_start";
	doganim[doganim.size] = prefix + "attackidle_bark";

	return doganim;
}