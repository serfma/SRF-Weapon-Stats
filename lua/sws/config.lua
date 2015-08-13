//-------Config file for Serf's Weapon Stats-------\\

//-------------------------------------------------\\
//Chance in which each weapon will get a rarity    \\
//assigned to it. Number 1 - 100				   \\
//-------------------------------------------------\\
sws.config.chance = 25

//-------------------------------------------------\\
//Enable or disable halos on weapons.		       \\
//Be aware that with this option enabled, it could \\
//cause low-end PCs to suffer FPS loss.            \\
//-------------------------------------------------\\
sws.config.halos = true

//-------------------------------------------------\\
//Colors for the weapon stats HUD and other things.\\
//-------------------------------------------------\\
sws.cols = {
	dark_blue = Color(0, 88, 95),
	light_blue = Color(0, 147, 147),
	light_tan = Color(255, 252, 196),
	dark_tan = Color(240, 237, 187),
	orange = Color(255, 56, 0),	
}

//--------------------------------------------------\\
//Set the weapon rarities down below. The very      \\
//first rarity will ALWAYS be weapons that WILL NOT \\
//have any stats added to it. 						\\
//													\\
//Col is the color of the rarity. This will set the \\
//weapon's name and glow color to it.               \\
//													\\
//sws.rarity.value is the overall rarity value.     \\
//The higher up the rarity, the more common it will \\
//be.		                                        \\
//--------------------------------------------------\\
sws.rarity = {
	--50 is the default rarity value. This sets Common to 50%,
	--Uncommon to 25%, Rare to 12.5%, Epic to 6.25% and Legendary to 3.12%. 
	value = 50,
	{
		name = "Common",
		col = Color( 255, 255, 255 ),
	},
	{
		name = "Uncommon",
		col = Color( 50, 255, 50 ),
		multi = 1
	},
	{
		name = "Rare",
		col = Color( 50, 50, 255 ),
		multi = 1.25
	},
	{
		name = "Epic",
		col = Color( 176, 0, 184 ),
		multi = 1.50
	},
	{
		name = "Legendary",
		col = Color( 232, 205, 2 ),
		multi = 1.75
	},
}

sws.abilities = {
	
}

//------------------------------------------------\\
//I've taken the liberty of setting every wep name.\\
//If you change any of these names, they will be    \\
//changed only on the weapon stats HUD. Nothing else.\\
//---------------------------------------------------\\
sws.wepnames = {
	["weapon_ttt_m16"] = "M16",
	["weapon_ttt_glock"] = "Glock",
	["weapon_ttt_knife"] = "Knife",
	["weapon_ttt_c4"] = "C4",
	["weapon_ttt_health_station"] = "Health Station",
	["weapon_ttt_beacon"] = "Beacon",
	["weapon_ttt_binoculars"] = "Binoculars",
	["weapon_ttt_confgrenade"] = "Discombobulator",
	["weapon_ttt_cse"] = "Visualizer",
	["weapon_ttt_decoy"] = "Decoy",
	["weapon_ttt_defuser"] = "Defuser",
	["weapon_ttt_flaregun"] = "Flare Gun",
	["weapon_ttt_phammer"] = "Poltergeist",
	["weapon_ttt_push"] = "Newton Launcher",
	["weapon_ttt_radio"] = "Radio",
	["weapon_ttt_sipistol"] = "Silenced Pistol",
	["weapon_ttt_smokegrenade"] = "Smoke Grenade",
	["weapon_ttt_stungun"] = "UMP Prototype",
	["weapon_ttt_teleport"] = "Teleporter",
	["weapon_ttt_unarmed"] = "Unarmed",
	["weapon_ttt_wtester"] = "DNA Tester",
	["weapon_zm_carry"] = "Magneto Stick",
	["weapon_zm_improvised"] = "Crowbar",
	["weapon_zm_mac10"] = "MAC 10",
	["weapon_zm_molotov"] = "Incendiary Grenade",
	["weapon_zm_pistol"] = "Pistol",
	["weapon_zm_revolver"] = "Deagle",
	["weapon_zm_rifle"] = "Scout",
	["weapon_zm_shotgun"] = "Shotgun",
	["weapon_zm_sledge"] = "H.U.G.E-249"
}