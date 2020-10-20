local PANEL = {}

function PANEL:Init()
  self.navbar = self:Add("CODEXLIST.Navbar")
  self.navbar:Dock(TOP)
  self.navbar:SetBody(self)
  self.navbar:AddTab("Items", "CODEXLIST.WeaponsTab")
  self.navbar:AddTab("Jobs", "CODEXLIST.JobsTab")
  self.navbar:AddTab("Dashboard", "CODEXLIST.Dashboard")
  self.navbar:SetActive(3)
end

function PANEL:PerformLayout(w, h)
 self.BaseClass.PerformLayout(self, w, h)
 
 self.navbar:SetTall(CODEXLIST.UISizes.navbar.height) 

end

vgui.Register("CODEXLIST.Menu", PANEL, "CODEXLIST.Frame")

CODEXLIST.Tests.Frame = function()
   local frame = vgui.Create("CODEXLIST.Menu")
   frame:SetSize(800, 600)
   frame:Center()
   frame:MakePopup()
   frame:SetTitle("Spring F4 Menu")
   
  end

concommand.Add("codexlist_frame", CODEXLIST.Tests.Frame)
