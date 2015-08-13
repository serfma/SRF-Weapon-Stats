surface.CreateFont("SWSInfo1", {font = "Viga",
									size = 24,
									antialias = true,
									outline = false,
									weight = 0})
surface.CreateFont("SWSInfo2", {font = "Titillium",
									size = 18,
									antialias = true,
									outline = false,
									weight = 1000})

sws.Halos = CreateClientConVar("sws_halos", 1, true, true)

local function box(x, y, w, h, col)
	draw.RoundedBoxEx(0, x, y, w, h, col, false, false, false, false)
end

local function shadowtxt(txt, font, x, y, color, align)
	draw.DrawText(txt, font, x+1, y+1, Color(0,0,0), align)
	draw.DrawText(txt, font, x, y, color, align)
end

local function txt(txt, font, x, y, color, align)
	draw.DrawText(txt, font, x, y, color, align)
end

local icon = {
	["Damage"] = surface.GetTextureID( "serfwepstats/" .. "Damage" .. ".vtf"),
	["Recoil"] = surface.GetTextureID( "serfwepstats/" .. "Recoil" .. ".vtf"),
	["Delay"] = surface.GetTextureID( "serfwepstats/" .. "Delay" .. ".vtf"),
	["ClipSize"] = surface.GetTextureID( "serfwepstats/" .. "ClipSize" .. ".vtf"),
	["ClipMax"] = surface.GetTextureID( "serfwepstats/" .. "ClipMax" .. ".vtf"),
	["Cone"] = surface.GetTextureID( "serfwepstats/" .. "Cone" .. ".vtf")
}

local function hudstats()
	local wep = LocalPlayer():GetActiveWeapon()
	if not IsValid( wep ) then return end
	if wep.Kind < 2 or wep.Kind > 3 then
		timer.Destroy( "SWSHUDTimer" )
		hook.Remove( "HUDPaint", "SWSHUDPaint" )
		return
	end

	local rarity = sws:GetRarity(wep)
	local trait = sws:GetTrait(wep)

	local framew, frameh = 228, 116
	local framex, framey = ScrW()-framew, ScrH()-frameh

	box( framex, framey, framew, frameh, sws.cols.dark_blue)
	box( framex, framey, framew, 24, sws.cols.orange )
	txt( sws:GetName( wep ), "SWSInfo1", framex + framew/2, framey, sws.rarity[rarity].col, TEXT_ALIGN_CENTER )

	for i=1,#sws.stats do
		local stat = sws.stats[i]
		if stat == "DefaultClip" then continue end

		local iconw, iconh = 26, 26
		local iconx, icony = framex + 3, framey + 30*i - 3
		if i > 3 then iconx, icony = framex + 115, framey + 30*(i-3) - 3 end

		//Set icons first
		surface.SetTexture( icon[stat]  )
		surface.SetDrawColor( color_white )
		surface.DrawTexturedRect( iconx, icony, iconw, iconh )

		----------------------------------------

		local statdefault = sws:GetDefaultStatValue(wep, stat)
		local statbonus = math.Round( sws:GetBonusStatValue( wep, stat ), 3 )
		
		surface.SetFont( "SWSInfo2" )
		local textw, texth = surface.GetTextSize( statdefault )
		local textx, texty = iconx + 30, icony + 2
		txt( statdefault, "SWSInfo2", textx, texty, sws.cols.light_blue, TEXT_ALIGN_LEFT )

		local bonusx, bonusy = textx + textw + 2, icony + 2
		if statbonus > 0 then txt( "+" .. statbonus, "SWSInfo2", bonusx, bonusy, sws.cols.orange, TEXT_ALIGN_LEFT ) end
		if statbonus < 0 then txt( statbonus, "SWSInfo2", bonusx, bonusy, sws.cols.orange, TEXT_ALIGN_LEFT ) end

		
	end

	
end

net.Receive( "SWSHUD", function()
	hook.Add( "HUDPaint", "SWSHUDPaint", hudstats )
	timer.Create( "SWSHUDTimer", 30, 1, function() hook.Remove( "HUDPaint", "SWSHUDPaint" ) end)
end)

hook.Add( "PreDrawHalos", "SWSHaloWeps", function()
	if GetConVarNumber( "sws_halos" ) == 0 then return end
	if sws.config.halos == false then return end

	local rarity
	local tbl = tbl or {}
	for i=1,#sws.rarity do
		tbl[i] = tbl[i] or {}
	end

	for k,v in pairs( ents.FindByClass( "weapon_*" ) ) do
		rarity = sws:GetRarity( v )
		if rarity == 1 then continue end

		table.insert( tbl[rarity], v  )
	end

	for k,v in pairs( tbl ) do
		halo.Add( tbl[k], sws.rarity[k].col, 0, 0, 0 )	
	end
end )