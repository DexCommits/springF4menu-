local PANEL = {}

CODEXLIST:CreateFont("Weapons.Category.Name", 22)
CODEXLIST:CreateFont("Weapons.Category.Desc", 18)
CODEXLIST:CreateFont("Weapons.Category.Price", 14)

function PANEL:Init()
  self:DockPadding(16, 16, 16, 16)

  self.scrollpanel = self:Add("DScrollPanel")
  self.scrollpanel:Dock(FILL)
  
  self.layout = self.scrollpanel:Add("DListLayout")
  self.layout:Dock(FILL)
end

function PANEL:CreateRow(cat, index, value)
  local panel = self.layout:Add("Panel")
  panel:Dock(TOP)
  panel:SetTall(48)
  panel:DockMargin(0, 0, 0, 6)
  panel.Paint = function(pnl, w, h)
    draw.RoundedBox(6, 0, 0, w, h, CODEXLIST.Theme.backgroundItems)
	
	local x = pnl.model:GetWide() + 8
	local y = h / 2 - (draw.GetFontHeight("CODEXLIST.Weapons.Category.Desc") / 2)
	draw.SimpleText(value.name, "CODEXLIST.Weapons.Category.Name", x, y, CODEXLIST.Theme.text.h2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	y = h / 2 + draw.GetFontHeight("CODEXLIST.Weapons.Category.Desc") / 2
	draw.SimpleText(value.desc, "CODEXLIST.Weapons.Category.Desc", x, y, CODEXLIST.Theme.text.h2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
  end
  panel.model = panel:Add("DModelPanel")
  panel.model:Dock(LEFT)
  panel.model:SetMouseInputEnabled(false)
  panel.model.LayoutEntity = function() end
  local oldPaint = baseclass.Get("DModelPanel").Paint
  panel.model.Paint = function(pnl, w, h)
    draw.RoundedBoxEx(6, 0, 0, w, h, CODEXLIST.Theme.weaponIconFill, true, false, true, false)
	
	oldPaint(pnl, w, h)
	end
  panel.model:SetModel(value.mdl)
  local mn, mx = panel.model.Entity:GetRenderBounds()
  local size = 0
  size = math.max(size, math.abs(mn.x) + math.abs(mx.x))
  size = math.max(size, math.abs(mn.y) + math.abs(mx.y))
  size = math.max(size, math.abs(mn.z) + math.abs(mx.z))
  panel.model:SetFOV(45)
  panel.model:SetCamPos(Vector(
    size,
	size,
	size
	)
  )
  panel.model:SetLookAt((mn + mx) * 0.5)
  
  local col = LocalPlayer():canAfford(value.price) and CODEXLIST.Theme.weaponIconFill or CODEXLIST.Theme.red
  panel.buy = panel:Add("DButton")
  panel.buy:SetText("Buy " .. DarkRP.formatMoney(value.price))
  panel.buy:SetTextColor(col)
  panel.buy:SetFont("CODEXLIST.Weapons.Category.Price")
  panel.buy.Paint = function(pnl, w, h)
    draw.RoundedBox(6, 0, 0, w, h, CODEXLIST.Theme.weaponIconFill)
  end
  
  panel.buy.DoClick = function(pnl)
   if (!LocalPlayer():canAfford(value.price)) then return end
   local itemId = index

   net.Start("Weapons.Purchase")
     net.WriteUInt(cat, 8)
	 net.WriteUInt(itemId, 16)
   net.SendToServer()
  end
  
  panel.PerformLayout = function(pnl, w, h)
    panel.buy:SizeToContentsX(24)
	panel.buy:SizeToContentsY(18)
	panel.buy:CenterVertical()
	panel.buy:AlignRight(10)
  
  end
end

function PANEL:SetData(tbl)
  self.layout:Clear()
  local index = tbl.index
  for i, v in pairs(tbl.items) do
  self:CreateRow(index, i, v)
  end
end
vgui.Register("CODEXLIST.Weapons.Category", PANEL)