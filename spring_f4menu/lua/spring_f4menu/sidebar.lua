local PANEL = {}

AccessorFunc(PANEL, "m_body", "Body")

CODEXLIST:CreateFont("Sidebar.Button", 18)

function PANEL:Init()
   self.buttons = {}
   self.panels = {}
   
   self:DockPadding(0, 6, 0, 6)

end

function PANEL:AddTab(name, panel, data)
  local i = table.Count(self.buttons) + 1
  self.buttons[i] = self:Add("DButton")
  local btn = self.buttons[i]
  btn:Dock(TOP)
  btn.id = i
  btn.data = data
  btn:DockMargin(0, 0, 0, 0)
  btn:SetText(name)
  btn:SetFont("CODEXLIST.Sidebar.Button")
  btn:SetContentAlignment(4)
  btn:SetTextInset(12, 0)
  btn.Paint = function(pnl, w, h)
    if (self.active == pnl.id) then
	  surface.SetDrawColor(CODEXLIST.Theme.accent)
	  surface.DrawRect(w - 2, 0, 2, h)
	 end
	end
  btn:SizeToContentsX(24)
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
  if (self.active == id) then return end
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
  if (panel.SetData) then
    panel:SetData(btn.data)
	end
 end
 
 function PANEL:SetActiveName(name)
 for i, btn in pairs(self.buttons) do
   if (btn:GetText() == name) then
    self:SetActive(btn.id)
	
	break
	end
   end
end

function PANEL:PerformLayout(w, h)
  surface.SetFont("CODEXLIST.Sidebar.Button")
  local width = 0
  
  for i, v in pairs(self.buttons) do
    local tw, th = surface.GetTextSize(v:GetText())
	tw = tw + 32
	
	if (tw > width) then 
	 width = tw
	end
end

self:SetWide(width)
end

function PANEL:Paint(w, h)
  draw.RoundedBoxEx(6, 0, 0, w, h, CODEXLIST.Theme.primary, true, true, true, false)
end

vgui.Register("CODEXLIST.Sidebar", PANEL)