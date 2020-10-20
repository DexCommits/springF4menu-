local PANEL = {}

AccessorFunc(PANEL, "m_body", "Body")

CODEXLIST:CreateFont("Navbar.Button", 18)
function PANEL:Init()
  -- self.active = 
  
  self.buttons = {}
  self.panels = {}
end

function PANEL:AddTab(name, panel)
  local i = table.Count(self.buttons) + 1
  self.buttons[i] = self:Add("DButton")
  local btn = self.buttons[i]
  btn:Dock(LEFT)
  btn.id = i
  btn:DockMargin(0, 2, 0, 0)
  btn:SetText(name)
  btn:SetFont("CODEXLIST.Navbar.Button")
  btn.Paint = function(pnl, w, h)
    if (self.active == pnl.id) then
	  surface.SetDrawColor(CODEXLIST.Theme.accent)
	  surface.DrawRect(0, h - 2, w, 2)
	 end
	end
  btn:SizeToContentsX(32)
  btn:SetTextColor(CODEXLIST.Theme.text.h4)
  btn.DoClick = function(pnl)
   self:SetActive(pnl.id)
  
end

 self.panels[i] = self:GetBody():Add(panel or "DPanel")
 panel = self.panels[i]
 panel:Dock(FILL)
 panel:SetVisible(false)
end

function PANEL:SetActive(id)
  local btn = self.buttons[id]
  if (!IsValid(btn)) then return end
  
  local activeBtn = self.buttons[self.active]
  if (IsValid(activeBtn)) then
    activeBtn:SetTextColor(CODEXLIST.Theme.text.h4)
	
	local activePnl = self.panels[self.active]
	if (IsValid(activePnl)) then
	activePnl:SetVisible(false)
	end
  end
 
  
  self.active = id
  
  btn:SetTextColor(CODEXLIST.Theme.accent)
  local panel = self.panels[id]
  panel:SetVisible(true)
 end
 
 function PANEL:SetActiveName(name)
 for i, btn in pairs(self.buttons) do
   if (btn:GetText() == name) then
    self:SetActive(btn.id)
	
	break
	end
   end
end


function PANEL:Paint(w, h)
  surface.SetDrawColor(CODEXLIST.Theme.primary)
  surface.DrawRect(0, 0, w, h)
  surface.SetDrawColor(CODEXLIST.Theme.secondaryLine)
  surface.DrawRect(0, 0, w, 2)
end

vgui.Register("CODEXLIST.Navbar", PANEL)