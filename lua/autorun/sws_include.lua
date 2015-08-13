sws = sws or {}
sws.config = sws.config or {}

if SERVER then
	AddCSLuaFile()
	AddCSLuaFile("sws/config.lua")
	AddCSLuaFile("sws/sh_stats.lua")
	AddCSLuaFile("sws/sh_sws.lua")
	AddCSLuaFile("sws/cl_hud.lua")
	AddCSLuaFile("sws/cl_sws.lua")
	
	include("sws/config.lua")
	include("sws/sh_stats.lua")
	include("sws/sv_wepstats.lua")
	include("sws/sh_sws.lua")
	
	return
end

-- CLIENT FILES
include("sws/config.lua")
include("sws/sh_stats.lua")
include("sws/cl_hud.lua")
include("sws/cl_sws.lua")
include("sws/sh_sws.lua")