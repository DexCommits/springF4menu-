CODEXLIST = CODEXLIST or {}
CODEXLIST.Tests = {}

function CODEXLIST:IncludeClient(path)

  
  
  if CLIENT then 
  include("spring_f4menu/" .. path .. ".lua")
  end
  
  if SERVER then
   AddCSLuaFile("spring_f4menu/" .. path .. ".lua")
   end
end
  
 function CODEXLIST:IncludeServer(path)
	
	if (SERVER) then
	include("spring_f4menu/" .. path .. ".lua")
	end
end

function CODEXLIST:IncludeShared(path)
	self:IncludeServer(path)
	self:IncludeClient(path)
end



    -- Configuration
CODEXLIST:IncludeShared("config/config")
	

	-- Networking files
CODEXLIST:IncludeClient("network/cl_init")
CODEXLIST:IncludeServer("network/init")
CODEXLIST:IncludeServer("network/network")
	
	-- Main files
CODEXLIST:IncludeClient("darkrp")
CODEXLIST:IncludeClient("bshadows")
CODEXLIST:IncludeClient("font")
CODEXLIST:IncludeClient("frame")
CODEXLIST:IncludeClient("navbar")
CODEXLIST:IncludeClient("testframe")
CODEXLIST:IncludeClient("sidebar")
CODEXLIST:IncludeClient("weapons_tab")
CODEXLIST:IncludeClient("weapons_tab_category")
CODEXLIST:IncludeClient("jobs_tab")
CODEXLIST:IncludeClient("ents_tab")
CODEXLIST:IncludeClient("weps_tab")
CODEXLIST:IncludeClient("ammo_tab")
CODEXLIST:IncludeClient("dashboard")



CODEXLIST.Weapons = {
  [1] = {
     name = "Shipments"
	 },
	
}
CODEXLIST.Entities = {
  [1] = {
     name = "Entities"
	 },
	
}
CODEXLIST.Ammo = {
  [1] = {
     name = "Ammo"
	 },
	
}