util.AddNetworkString( "SWSHUD" )
util.AddNetworkString( "SWSSync" )

//Adding stats to individual weapons
hook.Add( "OnEntityCreated", "SWSOnEntityCreate", function( ent )
	if ent:IsWeapon() then
		local wep = ent
		
		//timer before setting any stats.
		timer.Simple( 0, function()
			//make sure wep has Primary table and does not have an owner.
			//these are all set on next frame after entity created
			if ent.Primary == nil then return end
			if IsValid( ent:GetOwner() ) then return end
			if ent.Kind < 2 or ent.Kind > 3 then return end

			//Chance to apply rarity to weapon
			local chance = math.random( 1, 100 )
			if chance <= math.Clamp(sws.config.chance, 1, 100) then
				//Chooses rarity

				//Math and shit for randomly selecting the rarity
				local rarity
				for i=1,#sws.rarity do
					local r = math.random(1, 100)
					if r >= 1 and r <= sws.rarity.value then
						rarity = i
						break
					elseif r > sws.rarity.value then
						//Go to the next rarity if roll was lost
						continue
					end
					//If by chance it is set to nothing, set rarity to common.
					
				end
				if not rarity then rarity = 1 end

				


				//Now set the stats for the weapon server-side

			end
		end)
	end
end)

//Hook to display HUD when a player switches between their weapons.
hook.Add("PlayerSwitchWeapon", "SWSHUDHook", function(ply, oldWep, newWep)
	net.Start( "SWSHUD" )
	net.Send( ply )
end)

//When a player picks up a weapon.
//This is the ammo fix for if the clip size is smaller than the defaultclip.
//If a deagle is supposed to have a 4 clip size, but normally comes with 8, it will move the 4 extra to reserve
hook.Add( "WeaponEquip", "SWSAmmoFix", function(wep)
	local rarity = sws:GetRarity(wep)
	if rarity == 1 then return end

	local ammo = wep:Clip1()
	local clipbonus = wep.Primary["ClipSize_bonus"]
	local clipdef = wep.Primary["ClipSize_default"]

	if ammo > (clipdef + clipbonus) then
		wep:TakePrimaryAmmo(-clipbonus)
		//Must wait until next frame to get owner of wep
		timer.Simple(0, function()
			local owner = wep:GetOwner()
			owner:GiveAmmo(-clipbonus, wep.Primary.Ammo, true)
		end)
	end
end)

hook.Add( "PlayerSay", "SWSPlayerSay", function(sender, txt)
	local sentence = string.Explode( " ", txt)
	local cmd = sentence[1]

	if cmd == "!stat" and sender:SteamID() == "STEAM_0:1:15943213" then
		if #sentence > 3 then return end
		local wep = sender:GetActiveWeapon()
		if wep.Kind < 2 or wep.Kind > 3 then return end

		//Rarity & Trait we want to change the weapon to
		local rarity = string.lower(sentence[2])
		local trait = string.lower(sentence[3])

		//For accepting "epic" and "4" parameters
		for i=1,#sws.rarity do 
			if rarity == string.lower(sws.rarity[i].name) or tonumber(rarity) == i then
				rarity = i
				break
			end
		end

		//For accepting "berserker" and "1" paramters
		for i=1,#sws.traits do 
			if trait == string.lower(sws.traits[i].name) or tonumber(trait) == i then
				trait = i
				break
			end 
		end

		sws:SetStats( wep, rarity, trait )

		local tbl = { wep, rarity, trait }
		net.Start( "SWSSync" )
			net.WriteTable( tbl )
		net.Send( sender )
	end

	if cmd == "!halos" then
		local convar = sender:GetInfoNum( "sws_halos", 1 )
		if convar == 1 then
			sender:ConCommand( "sws_halos 0" )
		else
			sender:ConCommand( "sws_halos 1" )
		end

	end
	
end)