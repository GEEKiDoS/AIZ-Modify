/* Exo mode by tmaxScript. Available in AIZE 2.1 R1 */

#include maps\mp\gametypes\watchMoveButtons;

doublejump()
{
	while(isAlive(self)) {
		while (self isOnGround() && !self isOnLadder() && !self isMantling())
			wait 0.05;

		self thread dothejump();
		self thread dothedash();
		while (!self isOnGround())
			wait 0.05;
		self notify("double jump end");
		wait 0.05;
	}
}

dothejump()
{
	self endon("double jump end");
	self notifyOnPlayerCommand("jump", "+gostand");
	wait 0.1;
	while(1) {
		self waittill("jump");
		if(self getStance() != "stand")
			continue;
		
		vel = self getVelocity();	
		self setVelocity((vel[0], vel[1], getDvarInt("sv_doubleJumpMult"))); //500
		self playLocalSound("mp_killstreak_hellfire");
		self playSoundToTeam("mp_killstreak_hellfire","allies",self);
		wait 1.5;
	}
}
dothedash()
{
	self endon("double jump end");
	self notifyOnPlayerCommand("dash", "+breath_sprint");
	wait 0.1;
	while(1) {
		self waittill("dash");
		if(self getStance() != "stand")
			continue;
		
		vel = self getVelocity();
		newVel = (self getDashDirection())*getDvarInt("sv_dashMult"); //500
		len = length(newvel)/length((newvel[0], newvel[1], 0));
		
		self setVelocity((newVel[0]*len, newVel[1]*len, vel[2]));
		self playlocalsound("mp_killstreak_radar");
		self playSoundToTeam("mp_killstreak_radar","allies",self);
		wait 1.5;
	}
}

getDashDirection()
{
	direction = (0,0,0);
	curDirection = [];
		
	if(self isMoveButtonPressed("w")) //because of priority
		curDirection[curDirection.size] = anglesToForward(self getPlayerAngles());
	if(self isMoveButtonPressed("s"))
		curDirection[curDirection.size] = anglesToForward(self getPlayerAngles())*-1;
	if (self isMoveButtonPressed("a"))
		curDirection[curDirection.size] = anglesToRight(self getPlayerAngles())*-1;
	if (self isMoveButtonPressed("d"))
		curDirection[curDirection.size] = anglesToRight(self getPlayerAngles());

	if(curDirection.size > 1) { // process dash based on sum of directional vectors
		for (i = 0; i < curDirection.size; i++)
			direction += curDirection[i];
		direction = VectorNormalize(direction);
	}
	else if (curDirection.size == 1) // process dash based on one pressed key
		direction = curDirection[0];
	else 
		direction = anglesToForward(self getPlayerAngles()); // process front dash if no keys pressed
	return direction;
}