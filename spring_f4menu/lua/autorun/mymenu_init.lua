CODEXLIST = CODEXLIST or {}
CODEXLIST.Dir = "mymenu"
CODEXLIST.Tests = {}

function CODEXLIST:IncludeClient(path)
  local str = self.Dir .. "/" .. path .. ".lua"
  
  
  if CLIENT then 
  include(str)
  end
  
  if SERVER then
   AddCSLuaFile(str)
   end
end
  
 function CODEXLIST:IncludeServer(path)
	local str = self.Dir .. "/" .. path .. ".lua"

	
	if (SERVER) then
	include(str)
	end
end


CODEXLIST:IncludeClient("cl_init")
CODEXLIST:IncludeServer("init")
CODEXLIST:IncludeClient("darkrp")
CODEXLIST:IncludeClient("theme")
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
CODEXLIST:IncludeServer("network")
CODEXLIST:IncludeClient("weps_tab")
CODEXLIST:IncludeClient("ammo_tab")
CODEXLIST:IncludeClient("dashboard")
CODEXLIST:IncludeClient("codex_config")

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