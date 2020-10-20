local PANEL = {}

AccessorFunc(PANEL, "m_body", "Body")

CODEXLIST:CreateFont("AmmoHeader", 18)


function PANEL:Init()

  self.sp = self:Add("DScrollPanel")
  self.sp:Dock(FILL)
  self.sp.Paint = function(self, w, h)
	  	 draw.RoundedBoxEx(6, 0, 0, w, h, CODEXLIST.Theme.background, false, false, false, false)

	  end
  
	  
   for k, v in pairs(GAMEMODE.AmmoTypes) do

    self.sp.bg = self.sp:Add("DPanel")
    self.sp.bg:Dock(TOP)
	self.sp.bg:SetSize(0, 100 )
	self.sp.bg:DockMargin(5, 5, 5, 5)
    self.sp.bg.Paint = function(self, w, h)
	  surface.SetDrawColor(75, 75, 75, 50)
	  surface.DrawRect(0, 0, w, h )
	  end
	  
	  surface.SetFont( "CODEXLIST.AmmoHeader" )
	  local ammonameX, ammonameY = surface.GetTextSize( v.name )


self.sp.bg.ammon = self.sp.bg:Add("DLabel")
self.sp.bg.ammon:SetText( v.name )
self.sp.bg.ammon:SetSize( ammonameX, ammonameY )
self.sp.bg.ammon:Dock( TOP )
self.sp.bg.ammon:DockMargin( 5, 5, 0, 0)
self.sp.bg.ammon:SetFont("CODEXLIST.AmmoHeader")
self.sp.bg.ammon:SetTextColor(CODEXLIST.Theme.text.h3)

self.sp.bg.ammon = self.sp.bg:Add("DModelPanel")
self.sp.bg.ammon:Dock( LEFT )
self.sp.bg.ammon:SetSize( 120, 50 )
self.sp.bg.ammon:SetModel( v.model )
local mn, mx = self.sp.bg.ammon.Entity:GetRenderBounds()
		local size = 0
		size = math.max( size, math.abs(mn.x) + math.abs(mx.x) )
		size = math.max( size, math.abs(mn.y) + math.abs(mx.y) )
		size = math.max( size, math.abs(mn.z) + math.abs(mx.z) )

		self.sp.bg.ammon:SetFOV( 55 )
		self.sp.bg.ammon:SetCamPos( Vector( size, size, size / 2 ) )
		self.sp.bg.ammon:SetLookAt( self.sp.bg.ammon.Entity:OBBCenter() )
		function self.sp.bg.ammon.Entity:LayoutEntity( ent )
			self.sp.bg.ammon:SetAngles( Angle( 0, RealTime() * 40 % 360, 0 ) )
		end

	  surface.SetFont( "CODEXLIST.AmmoHeader" )
	  local ammopriceX, ammopriceY = surface.GetTextSize( "Price: ".. DarkRP.formatMoney(v.price ) )

self.sp.bg.ammop = self.sp.bg:Add("DLabel")
self.sp.bg.ammop:SetText( "Price: ".. DarkRP.formatMoney(v.price ))
self.sp.bg.ammop:SetSize( ammopriceX, ammopriceY )
self.sp.bg.ammop:Dock( TOP )
self.sp.bg.ammop:DockMargin( 5, 1, 0, 0)
self.sp.bg.ammop:SetFont("CODEXLIST.AmmoHeader")
self.sp.bg.ammop:SetTextColor(CODEXLIST.Theme.weaponIconFill)
      
	  surface.SetFont( "CODEXLIST.AmmoHeader" )
      local ammoamountX, ammoamountY = surface.GetTextSize( "Amount: " .. v.amountGiven )
	  
self.sp.bg.ammoamount = self.sp.bg:Add("DLabel")
self.sp.bg.ammoamount:SetText( "Amount: " .. v.amountGiven )
self.sp.bg.ammoamount:SetSize( ammoamountX, ammoamountY )
self.sp.bg.ammoamount:Dock( TOP )
self.sp.bg.ammoamount:DockMargin( 5, 1, 0, 0)
self.sp.bg.ammoamount:SetFont("CODEXLIST.AmmoHeader")
self.sp.bg.ammoamount:SetTextColor(CODEXLIST.Theme.weaponIconFill)

self.sp.bg.buyammo = self.sp.bg:Add("DButton")
self.sp.bg.buyammo:Dock( BOTTOM )
self.sp.bg.buyammo:DockMargin( 5, 5, 5, 5)
self.sp.bg.buyammo:SetText( "Purchase" )
self.sp.bg.buyammo:SetFont("CODEXLIST.JobHeader")
self.sp.bg.buyammo.Paint = function(self, w, h)
   surface.SetDrawColor(CODEXLIST.Theme.button)
   surface.DrawRect( 0, 0, w, h)
   surface.SetDrawColor(CODEXLIST.Theme.button)
   surface.DrawOutlinedRect(0, 0, w, h)

end
self.sp.bg.buyammo.DoClick = function()
   RunConsoleCommand( "say", "/buyammo " .. k )
end
end

end
function PANEL:Paint()

end


vgui.Register("CODEXLIST.AmmoTab", PANEL)