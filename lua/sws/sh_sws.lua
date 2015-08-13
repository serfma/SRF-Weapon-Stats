function sws:IsCommon(wep)
	if sws:GetRarity(wep) != 1 then 
		return false 
	else
		return true 
	end
end

function sws:GetDefaultStatValue(wep, stat)
	if sws:IsCommon(wep) then
		return wep.Primary[stat]
	elseif !sws:IsCommon(wep) then
		return wep.Primary[stat .. "_default"]
	end
end

function sws:GetBonusStatValue(wep, stat)
	if sws:IsCommon(wep) then
		return 0
	elseif !sws:IsCommon(wep) then
		return wep.Primary[stat .. "_bonus"]
	end
end

function sws:SetStats(wep, rarity, trait)
	if rarity == 1 then return end
	local round = { "Damage", "ClipSize", "ClipMax", "DefaultClip" }
	local wepdata = wep.Primary

	if SERVER then
		wep:SetNWInt( "Rarity", rarity )
		wep:SetNWInt( "Trait", trait )
	end

	//For each of the stats, update them
	for i=1,#sws.stats do
		local stat = sws.stats[i]
		//First let's cache the default stats
		if not wepdata[stat .. "_default"] then
			wepdata[stat .. "_default"] = wepdata[stat]
		end
		local wepdef = wepdata[stat .. "_default"]

		//We will then set the bonus for each stat
		if stat == "DefaultClip" then
			wepdata[stat .. "_bonus"] = ( wepdef * ( sws.rarity[rarity].multi * sws.traits[trait]["ClipSize"] ) )
		else
			wepdata[stat .. "_bonus"] = ( wepdef * ( sws.rarity[rarity].multi * sws.traits[trait][stat] ) )
		end
		//If the stat needs rounding, round it.
		if table.HasValue(round, stat) then
			wepdata[stat .. "_bonus"] = math.Round(wepdata[stat .. "_bonus"])
		end
		local wepbonus = wepdata[stat .. "_bonus"]

		//Now we will modify the weapon stats
		wepdata[stat] = wepdef + wepbonus
	end
end

function sws:GetRarity(wep)
	return wep:GetNWInt( "Rarity", 1 )
end

function sws:GetTrait(wep)
	return wep:GetNWInt( "Trait" )
end

function sws:GetName(wep)
	if sws:IsCommon(wep) then
		return sws.wepnames[wep:GetClass()]
	elseif !sws:IsCommon(wep) then
		local rarity = sws:GetRarity(wep)
		local trait = sws:GetTrait(wep)

		return sws.traits[trait].name .. " " .. sws.wepnames[wep:GetClass()]
	end
end