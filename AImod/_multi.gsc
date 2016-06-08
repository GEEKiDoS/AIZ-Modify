#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include AImod\_OtherFunctions;

multikill()
{
	if(!isDefined(self.multi)) self.multi = 0;
	self.multi++;
	wait 1;
	switch( self.multi )
	{
		case 2:
			self thread AImod\_text::MuliKillTextPopup("Double Kill", (1,1,1), (0.3,0.9,0.3));
			self.bonus += 1;
			self notify("BONUS");
		break;
		
		case 3:
			self thread AImod\_text::MuliKillTextPopup("Triple Kill", (1,1,1), (0.9,0.5,0.3));
			self.bonus += 2;
			self notify("BONUS");
		break;
		
		case 4:
			self thread AImod\_Mod::TextPopup2( "Take that!!!" );
			obituary( "Zombies", self, "cardicon_doubletap" );
			self thread AImod\_text::MuliKillTextPopup("Multi Kill!", (1,1,1), (0.9,0.3,0.3));
			self.bonus += 2;
			self notify("BONUS");
		break;
		
		case 5:
			self thread AImod\_Mod::TextPopup2( "OMG!!!" );
			obituary( "Zombies", self, "cardicon_doubletap" );
			self thread AImod\_text::MuliKillTextPopup("Multi Kill!", (1,1,1), (0.9,0.3,0.3));
			self.bonus += 2;
			self notify("BONUS");
		break;
		
		case 6:
			self thread AImod\_Mod::TextPopup2( "That's gotta hurt!!!" );
			obituary( "Zombies", self, "cardicon_doubletap" );
			self thread AImod\_text::MuliKillTextPopup("Multi Kill!", (1,1,1), (0.9,0.3,0.3));
			self.bonus += 2;
			self notify("BONUS");
		break;
		
		case 7:
			self thread AImod\_Mod::TextPopup2( "Killing Spree!!!" );
			obituary( "Zombies", self, "cardicon_doubletap" );
			self thread AImod\_text::MuliKillTextPopup("Multi Kill!", (1,1,1), (0.9,0.3,0.3));
			self.bonus += 2;
			self notify("BONUS");
		break;
	}
	self.multi = 0;
}