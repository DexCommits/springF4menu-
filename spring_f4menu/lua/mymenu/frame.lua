local PANEL = {}

local matcloseBtn = Material("materials/closeBtn.png")

CODEXLIST:CreateFont("Header", 22)

function PANEL:Init()
 self.header = self:Add("Panel")
 self.header:Dock(TOP)
 self.header.Paint = function(pnl, w, h)
   draw.RoundedBoxEx(6, 0, 0, w, h, CODEXLIST.Theme.primary, true, true, false, false)

  end
  
 self.header.closeBtn = self.header:Add("DButton")
 self.header.closeBtn:Dock(RIGHT)
 self.header.closeBtn:SetText("")
 self.header.closeBtn.DoClick = function(pnl)
    self:Remove()
	end
	self.header.closeBtn.margin = 16
	self.header.closeBtn.Paint = function(pnl, w, h)
	   local margin = pnl.margin
	   
	   surface.SetDrawColor(CODEXLIST.Theme.closeBtn)
	   surface.SetMaterial(matcloseBtn)
	   surface.DrawTexturedRect(margin, margin, w - (margin * 2), h - (margin * 2))
	end
	
	self.header.title = self.header:Add("DLabel")
	self.header.title:Dock(LEFT)
	self.header.title:SetFont("CODEXLIST.Header")
	self.header.title:SetTextColor(CODEXLIST.Theme.text.h1)
	self.header.title:SetTextInset(16, 0)
end

function PANEL:SetTitle(text)
 self.header.title:SetText(text)
 self.header.title:SizeToContents()
end

function PANEL:PerformLayout(w, h)
 self.header:SetTall(CODEXLIST.UISizes.header.height)
 self.header.closeBtn:SetWide(self.header:GetTall())
end

function PANEL:Paint(w, h)
   local aX, aY = self:LocalToScreen()
   
   BSHADOWS.BeginShadow()
     draw.RoundedBox(6, 335, 165, 610, 439, CODEXLIST.Theme.background)
   BSHADOWS.EndShadow(2, 2, 2)
end


vgui.Register("CODEXLIST.Frame", PANEL, "EditablePanel")