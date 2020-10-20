local PANEL = {}

AccessorFunc(PANEL, "m_body", "Body")

CODEXLIST:CreateFont("EntHeader", 30)


function PANEL:Init()

  self.sp = self:Add("DScrollPanel")
  self.sp:Dock(FILL)
  self.sp.Paint = function(self, w, h)
	   draw.RoundedBoxEx(6, 0, 0, w, h, CODEXLIST.Theme.background, false, false, false, false)

	  end
  
	  
   for k, v in pairs(DarkRPEntities) do

    self.sp.bg = self.sp:Add("DPanel")
    self.sp.bg:Dock(TOP)
	self.sp.bg:SetSize(0, 100 )
	self.sp.bg:DockMargin(5, 5, 5, 5)
    self.sp.bg.Paint = function(self, w, h)
	  surface.SetDrawColor(75, 75, 75, 50)
	  surface.DrawRect(0, 0, w, h )
	  end
	  
	  surface.SetFont( "CODEXLIST.EntHeader" )
	  local entnameX, entnameY = surface.GetTextSize( v.name )


self.sp.bg.entn = self.sp.bg:Add("DLabel")
self.sp.bg.entn:SetText( v.name )
self.sp.bg.entn:SetSize( entnameX, entnameY )
self.sp.bg.entn:Dock( TOP )
self.sp.bg.entn:DockMargin( 5, 5, 0, 0)
self.sp.bg.entn:SetFont("CODEXLIST.EntHeader")
self.sp.bg.entn:SetTextColor(CODEXLIST.Theme.text.h3)

self.sp.bg.entn = self.sp.bg:Add("DModelPanel")
self.sp.bg.entn:Dock( LEFT )
self.sp.bg.entn:SetSize( 120, 50 )
self.sp.bg.entn:SetModel( v.model )
self.sp.bg.entn:SetLookAt( Vector( 60, 60, 60 ) )
local mn, mx = self.sp.bg.entn.Entity:GetRenderBounds()
		local size = 0
		size = math.max( size, math.abs(mn.x) + math.abs(mx.x) )
		size = math.max( size, math.abs(mn.y) + math.abs(mx.y) )
		size = math.max( size, math.abs(mn.z) + math.abs(mx.z) )

		self.sp.bg.entn:SetFOV( 55 )
		self.sp.bg.entn:SetCamPos( Vector( size, size, size / 2 ) )
		self.sp.bg.entn:SetLookAt( self.sp.bg.entn.Entity:OBBCenter() )
		function self.sp.bg.entn.Entity:LayoutEntity( ent )
			self.sp.bg.entn:SetAngles( Angle( 0, RealTime() * 40 % 360, 0 ) )
		end

	  surface.SetFont( "CODEXLIST.EntHeader" )
	  local entpriceX, entpriceY = surface.GetTextSize( "Price: ".. DarkRP.formatMoney(v.price ) )

self.sp.bg.entp = self.sp.bg:Add("DLabel")
self.sp.bg.entp:SetText( "Price: ".. DarkRP.formatMoney(v.price ))
self.sp.bg.entp:SetSize( entpriceX, entpriceY )
self.sp.bg.entp:Dock( TOP )
self.sp.bg.entp:DockMargin( 6, 6, 0, 0)
self.sp.bg.entp:SetFont("CODEXLIST.EntHeader")
self.sp.bg.entp:SetTextColor(CODEXLIST.Theme.weaponIconFill)

      local entmaxX, entmaxY = surface.GetTextSize( "Max: " .. v.max )
	  
self.sp.bg.entmax = self.sp.bg:Add("DLabel")
self.sp.bg.entmax:SetText( "Max: " .. v.max )
self.sp.bg.entmax:SetSize( entpriceX, entpriceY )
self.sp.bg.entmax:Dock( TOP )
self.sp.bg.entmax:DockMargin( 6, 1, 0, 0)
self.sp.bg.entmax:SetFont("CODEXLIST.EntHeader")
self.sp.bg.entmax:SetTextColor(CODEXLIST.Theme.weaponIconFill)

self.sp.bg.buyent = self.sp.bg:Add("DButton")
self.sp.bg.buyent:Dock( BOTTOM )
self.sp.bg.buyent:DockMargin( 5, 5, 5, 5)
self.sp.bg.buyent:SetText( "Purchase" )
self.sp.bg.buyent:SetFont("CODEXLIST.JobHeader")
self.sp.bg.buyent.Paint = function(self, w, h)
   surface.SetDrawColor(CODEXLIST.Theme.button)
   surface.DrawRect( 0, 0, w, h)
   surface.SetDrawColor(CODEXLIST.Theme.button)
   surface.DrawOutlinedRect(0, 0, w, h)

end
self.sp.bg.buyent.DoClick = function()
   RunConsoleCommand( "say", "/" ..v.cmd )
end
end

end
function PANEL:Paint()

end


vgui.Register("CODEXLIST.EntsTab", PANEL)