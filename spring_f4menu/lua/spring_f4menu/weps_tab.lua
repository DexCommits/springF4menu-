local PANEL = {}

AccessorFunc(PANEL, "m_body", "Body")

CODEXLIST:CreateFont("WepHeader", 30)
CODEXLIST:CreateFont("WepSmallText", 20)

function PANEL:Init()

  self.sp = self:Add("DScrollPanel")
  self.sp:Dock(FILL)
  self.sp.Paint = function(self, w, h)
	  	 draw.RoundedBoxEx(6, 0, 0, w, h, CODEXLIST.Theme.background, false, false, false, false)

	  end
  
    self.sp.bgz = self.sp:Add("DPanel")
    self.sp.bgz:Dock(TOP)
	self.sp.bgz:SetSize(0, 50 )
	self.sp.bgz:DockMargin(5, 5, 5, 5)
    self.sp.bgz.Paint = function(self, w, h)
	  surface.SetDrawColor(75, 75, 75, 50)
	  surface.DrawRect(0, 0, w, h )
	  end
	  
	self.sp.bgz.shipment = self.sp.bgz:Add("DLabel")
    self.sp.bgz.shipment:SetText( "Shipments" )
    self.sp.bgz.shipment:SetFont( "CODEXLIST.WepHeader" )
    self.sp.bgz.shipment:Dock( FILL )
    self.sp.bgz.shipment:DockMargin( 5, 0, 0, 0)
    self.sp.bgz.shipment:SetTextColor(CODEXLIST.Theme.text.h3)

   for k, v in pairs(CustomShipments) do

    if( v.noship == false) then
    self.sp.bg = self.sp:Add("DPanel")
    self.sp.bg:Dock(TOP)
	self.sp.bg:SetSize(0, 100 )
	self.sp.bg:DockMargin(5, 5, 5, 5)
    self.sp.bg.Paint = function(self, w, h)
	  surface.SetDrawColor(75, 75, 75, 50)
	  surface.DrawRect(0, 0, w, h )
	  end
	  
	  surface.SetFont( "CODEXLIST.WepSmallText" )
	  local shipmentnameX, shipmentnameY = surface.GetTextSize( v.name )


self.sp.bg.shipmentn = self.sp.bg:Add("DLabel")
self.sp.bg.shipmentn:SetText( v.name )
self.sp.bg.shipmentn:SetSize( shipmentnameX, shipmentnameY )
self.sp.bg.shipmentn:Dock( TOP )
self.sp.bg.shipmentn:DockMargin( 5, 5, 0, 0)
self.sp.bg.shipmentn:SetFont("CODEXLIST.WepSmallText")
self.sp.bg.shipmentn:SetTextColor(CODEXLIST.Theme.text.h3)

self.sp.bg.spawnimage = self.sp.bg:Add("DModelPanel")
self.sp.bg.spawnimage:Dock( LEFT )
self.sp.bg.spawnimage:SetSize( 150, 50 )
self.sp.bg.spawnimage:SetModel( v.model )
local mn, mx = self.sp.bg.spawnimage.Entity:GetRenderBounds()
		local size = 0
		size = math.max( size, math.abs(mn.x) + math.abs(mx.x) )
		size = math.max( size, math.abs(mn.y) + math.abs(mx.y) )
		size = math.max( size, math.abs(mn.z) + math.abs(mx.z) )

		self.sp.bg.spawnimage:SetFOV( 55 )
		self.sp.bg.spawnimage:SetCamPos( Vector( size, size, size / 2 ) )
		self.sp.bg.spawnimage:SetLookAt( self.sp.bg.spawnimage.Entity:OBBCenter() )
		function self.sp.bg.spawnimage.Entity:LayoutEntity( ent )
			self.sp.bg.spawnimage:SetAngles( Angle( 0, RealTime() * 40 % 360, 0 ) )
		end


	  surface.SetFont( "CODEXLIST.WepSmallText" )
	  local shipmentpriceX, shipmentpriceY = surface.GetTextSize( "Price: ".. DarkRP.formatMoney(v.price ) )

self.sp.bg.shipmentp = self.sp.bg:Add("DLabel")
self.sp.bg.shipmentp:SetText( "Price: ".. DarkRP.formatMoney(v.price ))
self.sp.bg.shipmentp:SetSize( shipmentpriceX, shipmentpriceY )
self.sp.bg.shipmentp:Dock( TOP )
self.sp.bg.shipmentp:DockMargin( 6, 6, 0, 0)
self.sp.bg.shipmentp:SetFont("CODEXLIST.WepSmallText")
self.sp.bg.shipmentp:SetTextColor(CODEXLIST.Theme.weaponIconFill)

      surface.SetFont( "CODEXLIST.WepSmallText" )
      local shipmentamountX, shipmentamountY = surface.GetTextSize( "Max: " .. v.amount )
	  
self.sp.bg.shipmentamount = self.sp.bg:Add("DLabel")
self.sp.bg.shipmentamount:SetText( "Amount: " .. v.amount )
self.sp.bg.shipmentamount:SetSize( shipmentamountX, shipmentamountY )
self.sp.bg.shipmentamount:Dock( TOP )
self.sp.bg.shipmentamount:DockMargin( 6, 1, 0, 0)
self.sp.bg.shipmentamount:SetFont("CODEXLIST.WepSmallText")
self.sp.bg.shipmentamount:SetTextColor(CODEXLIST.Theme.weaponIconFill)

self.sp.bg.buyshipment = self.sp.bg:Add("DButton")
self.sp.bg.buyshipment:Dock( BOTTOM )
self.sp.bg.buyshipment:DockMargin( 5, 5, 5, 5)
self.sp.bg.buyshipment:SetText( "Purchase" )
self.sp.bg.buyshipment:SetFont("CODEXLIST.JobHeader")
self.sp.bg.buyshipment.Paint = function(self, w, h)
   surface.SetDrawColor(CODEXLIST.Theme.button)
   surface.DrawRect( 0, 0, w, h)
   surface.SetDrawColor(CODEXLIST.Theme.button)
   surface.DrawOutlinedRect(0, 0, w, h)

end
self.sp.bg.buyshipment.DoClick = function()
   RunConsoleCommand( "say", "/buyshipment " ..v.name )
end
end
end
end
function PANEL:Paint()

end


vgui.Register("CODEXLIST.WepsTab", PANEL)