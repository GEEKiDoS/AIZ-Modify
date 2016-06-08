/* Exo mode by tmaxScript. Available in AIZE 2.1 R1 */

watchMoveButtons()
{
	self.moveButton = [];
	self thread watchButton("w down", "+forward", "w", 1);
	self thread watchButton("w up", "-forward", "w", 0);
	self thread watchButton("a down", "+moveleft", "a", 1);
	self thread watchButton("a up", "-moveleft", "a", 0);
	self thread watchButton("s down", "+back", "s", 1);
	self thread watchButton("s up", "-back", "s", 0);
	self thread watchButton("d down", "+moveright", "d", 1);
	self thread watchButton("d up", "-moveright", "d", 0);
}

watchButton(ntfy, command, btn, state)
{
	self endon("disconnect");
	self notifyOnPlayerCommand(ntfy, command);
	self.moveButton[btn] = state;
	while(1) {
		self waittill(ntfy);
		self.moveButton[btn] = state;
	}
}

isMoveButtonPressed(btn) //ASSERT?!
{
	return self.moveButton[btn];
}