local PANEL = {}

function PANEL:Init()
  self.sidebar = self:Add("CODEXLIST.Sidebar")
  self.sidebar:Dock(LEFT)
  self.sidebar:SetBody(self)
  for i, v in ipairs(CODEXLIST.Weapons)  do
    self.sidebar:AddTab(v.name, "CODEXLIST.WepsTab", {
	  index = i,
	  items = v.items
	  })
  end
  for i, v in ipairs(CODEXLIST.Entities)  do
	self.sidebar:AddTab(v.name, "CODEXLIST.EntsTab", {
	  index = i,
	  items = v.items
	  })
  end
    for i, v in ipairs(CODEXLIST.Ammo)  do
	self.sidebar:AddTab(v.name, "CODEXLIST.AmmoTab", {
	  index = i,
	  items = v.items
	  })
  end
  self.sidebar:SetActive(1)
  self.sidebar:InvalidateLayout()
end

vgui.Register("CODEXLIST.WeaponsTab", PANEL)