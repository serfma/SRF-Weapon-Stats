//update the client so it knows what the fuck is up
hook.Add( "HUDWeaponPickedUp", "SWSOnPickup", function(wep)
	local rarity = sws:GetRarity(wep)
	if rarity == "" then return end
	local trait = sws:GetTrait(wep)

	sws:SetStats(wep, rarity, trait)
end)

net.Receive( "SWSSync", function() 
	local tbl = net.ReadTable()
	local wep = tbl[1]
	//Rarity & Trait that we want to change the weapon to
	local rarity = tbl[2]
	local trait = tbl[3]

	//Update the weapon in hand to the above rarity/trait
	sws:SetStats( wep, rarity, trait ) 
end)