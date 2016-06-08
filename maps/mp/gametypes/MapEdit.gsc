#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\SolidStuff;
#include maps\mp\gametypes\MapSpawns;
#include AImod\_OtherFunctions;
#include AImod\_weapon;
#include AImod\_hud;
#include AImod\_text;
#include AImod\BoxFunctions;

init()
{
	//Yamato - this must be threaded in init
	//AddBoxType( "ammo", "waypoint_ammo_friendly", ::AmmoRefill, "Hold ^3[{+activate}]^7 for an Ammo Refill", "waypoint_ammo_friendly" );
    //AddBoxType( "stalker", "specialty_pistoldeath_upgrade", ::SetStalker, "Hold ^3[{+activate}]^7 to get Stalker perk", "specialty_pistoldeath_upgrade" );
    waittillframeend;

	level.spawnlogic = [];
	level.boxicon = 0;
	level.box = 0;
	level.boxposition = 0;
	level.doCustomMap = 0;
	level.doorwait = 2;
	level thread mp\maps\mp_afghan::PrecacheAghan();
	level.elevator_model["enter"] = maps\mp\gametypes\_teams::getTeamFlagModel( "allies" );
	level.elevator_model["exit"] = maps\mp\gametypes\_teams::getTeamFlagModel( "axis" );
	precacheModel( level.elevator_model["enter"] );
	precacheModel( level.elevator_model["exit"] );
	precacheModel( "com_locker_double" );
	precacheModel( "com_teddy_bear" );
	precacheModel( "com_cellphone_on" ); //for music player
	//just doing it again... 
    game["menu_music_player"] = "music_player";	
	
	precacheMenu(game["menu_quickmessage"]);
	precacheMenu(game["menu_quickcommands"]);
	precacheMenu(game["menu_quickstatements"]);
	precacheMenu(game["menu_quickresponses"]);
	
	precacheMenu(game["menu_music_player"]);	
	
	wait 0.05;
	switch(getDvar("mapname"))
	{
		case "mp_afghan":
		/** Afghan **/ 
		switch(randomInt(2))
		{
			case 0:
			level thread Afghan();
			level.edit = 0;
			level thread mp\maps\mp_afghan::WaypointInit();
			break;
			case 1:
			level thread Afghan2();
			level.edit = 1;
			level thread mp\maps\mp_afghan::Afghan2Init();
			break;
		}
		break;
		case "mp_boneyard":
		/** Scrapyard **/ 
		level thread Scrapyard();
		level thread mp\maps\mp_scrapyard::WaypointInit();
		break;
		case "mp_brecourt":
		/** Wasteland **/ 
		level thread Wasteland();
		level thread mp\maps\mp_wasteland1::Init();
		level thread mp\maps\mp_wasteland1::WaypointInit();
		break;
		case "mp_checkpoint":
		/** Karachi **/ 
		level thread Karachi();
		break;
		case "mp_derail":
		/** Derail **/ 
		switch(randomInt(2))
		{
			case 0:
			level thread Derail();
			level.edit = 0;
			level thread mp\maps\mp_derail::WaypointInit();
			break;
			case 1:
			level thread Derail2();
			level.edit = 1;
			break;
		}
		break;
		case "mp_estate":
		/** Estate **/ 
		level thread Estate();
		level.power = true;
		break;
		case "mp_favela":
		/** Favela **/ 
		switch(randomInt(3))
		{
			case 0:
			level thread Favela();
			level.edit = 0;
			break;
			case 1:
			level thread Favela2();
			level.edit = 1;
			break;
			case 2:
			level thread Favela3();
			level.edit = 2;
			break;
		}
		break;
		case "mp_highrise":
		/** HighRise **/ 
		switch(randomInt(2))
		{
			case 0: //High Hilton
			level thread HighRise();
			level.edit = 0;
			level thread mp\maps\mp_highrise::WaypointInit();
			break;
			case 1: //Infestation
			level thread HighRise2();
			level thread mp\maps\mp_highrise2::Init();
			level.edit = 1;
			break;
		}
		break;
		case "mp_nightshift":
		/** Skidrow **/
		switch(randomInt(3))
		{
			case 0:
			level thread Skidrow();
			level thread mp\maps\mp_skidrow::WaypointInit();
			level.edit = 0;
			break;
			case 1:
			level thread Skidrow2();
			level thread mp\maps\mp_skidrow2::Init();
			level thread mp\maps\mp_skidrow2::WaypointInit();
			level.edit = 1;
			break;
			case 2:
			level thread Skidrow3();
			level.edit = 2;
			break;
		}
		break;
		case "mp_invasion":
		/** Invasion **/ 
		level thread Invasion();
		level thread mp\maps\mp_invasion::Init();
		level thread mp\maps\mp_invasion::WaypointInit();
		break;
		case "mp_quarry":
		/** Quarry **/ 
		level thread Quarry();
		level thread mp\maps\mp_quarry::Init();
		level thread mp\maps\mp_quarry::WaypointInit();
		break;
		case "mp_rundown":
		/** Rundown **/ 
		level thread Rundown();
		level thread mp\maps\mp_rundown::Init();
		level thread mp\maps\mp_rundown::WaypointInit();
		break;
		case "mp_rust":
		/** Rust **/ 
		level thread Rust();
		level thread mp\maps\mp_rust::Init();
		level thread mp\maps\mp_rust::WaypointInit();
		break;
		case "mp_subbase":
		/** SubBase **/ 
		level thread SubBase();
		level thread mp\maps\mp_subbase::Init();
		break;
		case "mp_terminal":
		/** Terminal **/ 
		level thread Terminal();
		level thread mp\maps\mp_terminal1::Init();
		level thread mp\maps\mp_terminal1::WaypointInit();
		break;
		case "mp_underpass":
		/** Underpass **/ 
		level thread Underpass();
		level thread mp\maps\mp_underpass::WaypointInit();
		break;
		case "mp_overgrown":
		/** Overgrown **/ 
		level thread Overgrown();
		break;
		case "mp_trailerpark":
		/** TrailerPark **/ 
		level thread Trailerpark();
		level thread mp\maps\mp_trailerpark::WaypointInit();
		break;
		case "mp_compact":
		/** Salvage **/ 
		level thread Salvage();
		level thread mp\maps\mp_salvage::Init();
		level thread mp\maps\mp_salvage::WaypointInit();
		break;
		case "mp_strike":
		/** Strike **/ 
		level thread Strike();
		break;
		case "mp_complex":
		/** Bailout **/
		level thread Bailout();
		level thread mp\maps\mp_bailout::Init();
		level thread mp\maps\mp_bailout::WaypointInit();
		break;
		case "mp_abandon":
		/** Carnival **/
		level thread Carnival();
		level thread mp\maps\mp_carnival::WaypointInit();
		break;
		case "mp_vacant":
		/** Vacant **/
		level thread Vacant();
		level thread mp\maps\mp_vacant::WaypointInit();
		break;
		case "mp_storm":
		/** Storm **/
		level thread Storm();
		level thread mp\maps\mp_storm::WaypointInit();
		break;
		case "mp_fuel2":
		/** Fuel **/
		level thread Fuel();
		break;
		case "mp_crash":
		/** Crash **/
		level thread Crash();
		level thread mp\maps\mp_crash::WaypointInit();
		level.power = true;
		break;
		case "estate":
		/** Safehouse **/
		level thread Safehouse();
		level thread mp\maps\safehouse::Init();
		level thread mp\maps\safehouse::WaypointInit();
		break;
		case "co_hunted":
		/** Village **/
		level thread Village();
		break;
		case "arcadia":
		/** Arcadia **/
		level thread arcadia();
		break;
		case "contingency":
		/** Contingency **/
		level thread mp\maps\contingency::Init();
		level thread mp\maps\contingency::WaypointInit();
		level thread Contingency();
		break;
		case "oilrig":
		/** Oilrig **/
		level thread Oilrig();
		break;
		case "mp_nuked":
		/** Nuketown **/
		level thread Nuketown();
		level thread mp\maps\mp_nuked::Init();
		level thread mp\maps\mp_nuked::WaypointInit();
		break;
		case "invasion":
		/** BurgerTown **/
		level thread BurgerTown();
		level thread mp\maps\invasion::Init();
		level thread mp\maps\invasion::WaypointInit();
		break;
		case "af_caves":
		/** Caves **/
		level thread Caves();
		level thread mp\maps\af_caves::Init();
		break;
		case "favela":
		switch(randomInt(2))
		{
			/** Favela Shanties **/
			case 0:
			level thread Shanties();
			level thread mp\maps\shanties::Init();
			level thread mp\maps\shanties::WaypointInit();
			level.edit = 0;
			break;
			/** Favela Shanties Hotel **/
			case 1:
			level thread Shanties_Hotel();
			level thread mp\maps\shanties_hotel::Init();
			level thread mp\maps\shanties_hotel::WaypointInit();
			level.edit = 1;
			break;
		}
		case "mp_cross_fire":
		/** Crossfire **/
		level thread Crossfire();
		break;
		case "mp_bloc":
		/** Bloc **/
		level thread Bloc();
		break;
		case "mp_cargoship":
		/** Wet Work **/
		level thread WetWork();
	}
}

CreateElevator(enter, exit, angle)
{
	flag = spawn( "script_model", enter );
	flag setModel( level.elevator_model["enter"] );
	wait 0.05;
	flag = spawn( "script_model", exit );
	flag setModel( level.elevator_model["exit"] );
	wait 0.05;
	self thread ElevatorThink(enter, exit, angle);
}

CreateBlocks(pos, angle)
{
	block = spawn("script_model", pos );
	block setModel("com_plasticcase_friendly");
	block.angles = angle;
	block Solid();
	block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	wait 0.05;
}

CreateRamps(top, bottom)
{
	D = Distance(top, bottom);
	blocks = roundUp(D/30);
	CX = top[0] - bottom[0];
	CY = top[1] - bottom[1];
	CZ = top[2] - bottom[2];
	XA = CX/blocks;
	YA = CY/blocks;
	ZA = CZ/blocks;
	CXY = Distance((top[0], top[1], 0), (bottom[0], bottom[1], 0));
	Temp = VectorToAngles(top - bottom);
	BA = (Temp[2], Temp[1] + 90, Temp[0]);
	for(b = 0;b < blocks;b++)
	{
		block = spawn("script_model", (bottom + ((XA, YA, ZA) * b)));
		block setModel("com_plasticcase_friendly");
		block.angles = BA;
		block Solid();
		block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
		wait 0.05;
	}
	block = spawn("script_model", (bottom + ((XA, YA, ZA) * blocks) - (0, 0, 5)));
	block setModel("com_plasticcase_friendly");
	block.angles = (BA[0], BA[1], 0);
	block Solid();
	block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
	wait 0.001;
}

CreateGrids(corner1, corner2, angle)
{
	W = Distance((corner1[0], 0, 0), (corner2[0], 0, 0));
	L = Distance((0, corner1[1], 0), (0, corner2[1], 0));
	H = Distance((0, 0, corner1[2]), (0, 0, corner2[2]));
	CX = corner2[0] - corner1[0];
	CY = corner2[1] - corner1[1];
	CZ = corner2[2] - corner1[2];
	ROWS = roundUp(W/55);
	COLUMNS = roundUp(L/30);
	HEIGHT = roundUp(H/20);
	XA = CX/ROWS;
	YA = CY/COLUMNS;
	ZA = CZ/HEIGHT;
	center = spawn("script_model", corner1);
	for(r = 0;r <= ROWS;r++)
	{
		for(c = 0;c <= COLUMNS;c++)
		{
			for(h = 0;h <= HEIGHT;h++)
			{
				block = spawn("script_model", (corner1 + (XA * r, YA * c, ZA * h)));
				block setModel("com_plasticcase_friendly");
				block.angles = (0, 0, 0);
				block Solid();
				block LinkTo(center);
				block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
				wait 0.001;
			}
		}
	}
	center.angles = angle;
}

CreateWalls(start, end)
{
	D = Distance((start[0], start[1], 0), (end[0], end[1], 0));
	H = Distance((0, 0, start[2]), (0, 0, end[2]));
	blocks = roundUp(D/55);
	height = roundUp(H/30);
	CX = end[0] - start[0];
	CY = end[1] - start[1];
	CZ = end[2] - start[2];
	XA = (CX/blocks);
	YA = (CY/blocks);
	ZA = (CZ/height);
	TXA = (XA/4);
	TYA = (YA/4);
	Temp = VectorToAngles(end - start);
	Angle = (0, Temp[1], 90);
	for(h = 0;h < height;h++)
	{
		block = spawn("script_model", (start + (TXA, TYA, 10) + ((0, 0, ZA) * h)));
		block setContents(1);
		block.angles = Angle;
		wait 0.0001;
		block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
		block hide();
		for(i = 1;i < blocks;i++)
		{
			block = spawn("script_model", (start + ((XA, YA, 0) * i) + (0, 0, 10) + ((0, 0, ZA) * h)));
			block setContents(1);
			block.angles = Angle;
			block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
			block hide();
			wait 0.0001;
		}
		block = spawn("script_model", ((end[0], end[1], start[2]) + (TXA * -1, TYA * -1, 10) + ((0, 0, ZA) * h)));
		block setContents(1);
		block.angles = Angle;
		block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
		block hide();
		wait 0.0001;
	}
}

CreateVisableWalls(start, end)
{
	D = Distance((start[0], start[1], 0), (end[0], end[1], 0));
	H = Distance((0, 0, start[2]), (0, 0, end[2]));
	blocks = roundUp(D/55);
	height = roundUp(H/30);
	CX = end[0] - start[0];
	CY = end[1] - start[1];
	CZ = end[2] - start[2];
	XA = (CX/blocks);
	YA = (CY/blocks);
	ZA = (CZ/height);
	TXA = (XA/4);
	TYA = (YA/4);
	Temp = VectorToAngles(end - start);
	Angle = (0, Temp[1], 90);
	for(h = 0;h < height;h++)
	{
		block = spawn("script_model", (start + (TXA, TYA, 10) + ((0, 0, ZA) * h)));
		block setModel("com_plasticcase_friendly");
		block.angles = Angle;
		wait 0.0001;
		block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
		for(i = 1;i < blocks;i++)
		{
			block = spawn("script_model", (start + ((XA, YA, 0) * i) + (0, 0, 10) + ((0, 0, ZA) * h)));
			block setModel("com_plasticcase_friendly");
			block.angles = Angle;
			block solid();
			block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
			wait 0.0001;
		}
		block = spawn("script_model", ((end[0], end[1], start[2]) + (TXA * -1, TYA * -1, 10) + ((0, 0, ZA) * h)));
		block setModel("com_plasticcase_friendly");
		block.angles = Angle;
		block solid();
		block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
		wait 0.0001;
	}
}

CreateCluster(amount, pos, radius)
{
	for(i = 0; i < amount; i++)
	{
		half = radius / 2;
		power = ((randomInt(radius) - half), (randomInt(radius) - half), 500);
		block = spawn("script_model", pos + (0, 0, 1000) );
		block setModel("com_plasticcase_friendly");
		block.angles = (90, 0, 0);
		block PhysicsLaunchServer((0, 0, 0), power);
		block Solid();
		block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
		block thread ResetCluster(pos, radius);
		wait 0.05;
	}
}

ElevatorThink(enter, exit, angle)
{
	self endon("disconnect");
	while(1)
	{
		foreach(player in level.players)
		{
			if(Distance(enter, player.origin) <= 50){
				player SetOrigin(exit);
				player SetplayerAngles(angle);
			}
		}
		wait .25;
	}
}

CreateHurtArea(pos, radius, height)
{
	HurtTrigger = spawn( "trigger_radius", pos, 0, radius, height );
	HurtTrigger thread HurtTriggerThink();
}
	
HurtTriggerThink()
{
	self endon("disconnect");
	while(1)
	{
		self waittill( "trigger", player );
		player thread maps\mp\gametypes\_damage::finishplayerDamageWrapper( self, self, 99, 0, "MOD_MELEE", "none", player.origin, player.origin, "none", 0, 0 );
		player IPrintLnBold("^1The infection is crawling up your ass :D");
		wait 1;
	}
}

ResetCluster(pos, radius)
{
	wait 5;
	self RotateTo(((randomInt(36)*10), (randomInt(36)*10), (randomInt(36)*10)), 1);
	level waittill("RESETCLUSTER");
	self thread CreateCluster(1, pos, radius);
	self delete();
}

roundUp( floatVal )
{
	if ( int( floatVal ) != floatVal )
	{
		return int( floatVal+1 );
	}
	else
	{
		return int( floatVal );
	}
}

CreateProgressArea(pos, radius, height, repeat, forceNum)
{
	level.spawnlogic = spawn( "trigger_radius", pos, 0, radius, height );
	Hasfound = 0;
	if( !Isdefined(forcenum) )
	{
		forcenum = 0;
	}
	level.spawnlogic thread playerEnterArea(radius, Hasfound, repeat, forcenum);
}

playerEnterArea(radius, didfind, repeat, forcenum, range)
{
	for(;;)
	{
		self waittill( "trigger", player );	
		level.progressmap = forcenum;
	}
}

CreateProgressAreaDebug(pos, radius, height, repeat, forceNum)
{
	Areatrigger = spawn( "trigger_radius", pos, 0, radius, height );
	Hasfound = 0;
	if( !Isdefined(forcenum) )
	{
		forcenum = 0;
	}
	Areatrigger thread playerEnterAreaDebug(radius, Hasfound, repeat, forcenum);
	foreach(player in level.players)
	{
		player.rTouch = 0;
	}
}

playerEnterAreaDebug(radius, didfind, repeat, forcenum, range)
{
	for( ;; )
	{
		wait 0.05;
		if(repeat == 1 && didfind == 1)
		{
			foreach(player in level.players)
			{
				if(Distance(self.origin, player.origin) >= radius * 1 && didfind == 1 && player.rTouch != 0)
				{
					level.progressmap = forcenum;
					didfind = 0;
					player IPrintLnBold("You left " + level.progressmap);
				}
			}
		}
		self waittill( "trigger", player );
		currentProgressNum = level.progressmap;
		wait 0.05;		
		if(repeat == 1)
		{
			if(Distance(self.origin, player.origin) <= radius)
			{
				player.rTouch = 1;
				level.progressmap = forcenum;
				didfind = 1;
				player IPrintLnBold("Area " + level.progressmap);
			}

		}
	}
}

EmpEffect(block)
{
	level._effect["empuse"] = loadfx ("explosions/emp_flash_mp");
	PlayFx(level._effect["empuse"],block.origin);
}

CreateFXonPos(pos,fx)
{
    playFX(fx, pos);
    angles = (90, 90, 0);
	wait 0.05;
}

BoxShader( shader )
{
    self endon( "death" );
    self endon( "disconnect" );
    trigger = Spawn( "trigger_radius", self.origin, 0, 150, 72 );
    trigger.icon = NewHudElem( );
    trigger.icon SetShader( shader, 50, 50 );
    trigger.icon.alpha = 0;
    trigger.icon.color = ( 1, 1, 1 );
    trigger thread UpdateShaderPos();
    trigger.icon SetWayPoint( true, true );
    wait ( 0.05 );
    while( isDefined(trigger) )
    {
        trigger waittill( "trigger", player );
        if( !isplayer( player ) )
            continue;
        while( player AImod\_waw::is_facing( self, 0.2 ) &&  player IsTouching( trigger ) ) 
        {
            if( VectorDot( anglesToForward( player.angles ), VectorNormalize( trigger.origin - player.origin ) ) > 0.566 )
                  FadeIcon( trigger.icon, "in" );
            else
                FadeIcon( trigger.icon, "out" );
            wait ( 0.05 ); 
        }
        FadeIcon( trigger.icon, "out" );
    }
}

FadeIcon( icon, what )
{
    if( what == "in" )
    {
        icon FadeOverTime( 0.2 );
        icon.alpha = 1;
        wait ( 0.2 );
    }
    else if( what == "out" )
    {
        icon FadeOverTime( 0.2 );
        icon.alpha = 0;
        wait ( 0.2 );
    }
    else
    {
        if( icon.alpha == 0 )
        {
            icon FadeOverTime( 0.2 );
            icon.alpha = 1;
            wait ( 0.2 );
        }
        else
        {
            icon FadeOverTime( 0.2 );
            icon.alpha = 0;
            wait ( 0.2 );
        }
    }
}

UpdateShaderPos()
{
    while( isDefined( self ) )
    {
        self.icon.x = self.origin[ 0 ];
        self.icon.y = self.origin[ 1 ];
        self.icon.z = self.origin[ 2 ] + 100;
        wait ( 0.05 );
    }
}