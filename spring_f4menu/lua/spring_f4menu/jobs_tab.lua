local PANEL = {}

AccessorFunc(PANEL, "m_body", "Body")

CODEXLIST:CreateFont("JobHeader", 20)


function PANEL:Init()

  self.scrollpanel = self:Add("DScrollPanel")
  self.scrollpanel:Dock(FILL)
  self.scrollpanel.Paint = function(self, w, h)
	  draw.RoundedBoxEx(6, 0, 0, w, h, CODEXLIST.Theme.background, true, true, false, false)

	  end
  
   for k, v in pairs(RPExtraTeams) do
    local category = v.category
   if not IsValid( self.scrollpanel[category] ) then
   self.scrollpanel[category] = self.scrollpanel:Add("DPanel")
   self.scrollpanel[category]:Dock( TOP )
   self.scrollpanel[category]:SetSize( 0, 300 )
   self.scrollpanel[category]:DockMargin( 5, 5, 5, 5)
   self.scrollpanel[category]:DockPadding( 0, 40, 0, 0)
   self.scrollpanel[category].Paint = function( self, w, h )
   local bgColor = self.color or Color(200, 200, 200, 200)
   surface.SetAlphaMultiplier( 0.5 )
   surface.SetDrawColor(bgColor)
   surface.DrawRect( 0, 0, w, 40 )
   surface.SetAlphaMultiplier( 1 )
   surface.SetDrawColor(CODEXLIST.Theme.text.h3)
   surface.DrawOutlinedRect( 0, 0, w, 40 )
   draw.SimpleText( category, "CODEXLIST.JobHeader", 20/2, 20, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
   end
   self.scrollpanel[category].jobCount = 0
   end
   
   local Tcategories = DarkRP.getCategories().jobs
   
   for k, v in pairs( Tcategories ) do
      if( category == v.name ) then
	    self.scrollpanel[category].color = v.color
		end
   end
   
   self.scrollpanel[category].jobCount = self.scrollpanel[category].jobCount + 1
   
   self.scrollpanel[category]:SetSize( 0, (self.scrollpanel[category].jobCount*210)+40 )
   
self.scrollpanel.bg = self.scrollpanel[category]:Add("DPanel")
self.scrollpanel.bg:Dock(TOP)
self.scrollpanel.bg:SetSize( 0, 200 )
self.scrollpanel.bg:DockMargin( 5, 5, 5, 5 )
self.scrollpanel.bg.Paint = function(self, h)
	  surface.SetDrawColor(v.color)
	  surface.DrawRect(0, 0, 400, h )
end

self.scrollpanel.bg.descbg = self.scrollpanel.bg:Add("DPanel")
self.scrollpanel.bg.descbg:SetSize( 350, 200 )
self.scrollpanel.bg.descbg:Dock( RIGHT )
self.scrollpanel.bg.descbg:DockMargin( 5, 5, 5, 5)
self.scrollpanel.bg.descbg.Paint = function( self, w, h )
    surface.SetDrawColor(CODEXLIST.Theme.primary)
	surface.DrawRect( 0, 0, w, h)

end
surface.SetFont("CODEXLIST.JobHeader")
local desX, desY = surface.GetTextSize( v.description )
self.scrollpanel.bg.descbg.desc = self.scrollpanel.bg.descbg:Add("DLabel")
self.scrollpanel.bg.descbg.desc:SetText( v.description )
self.scrollpanel.bg.descbg.desc:Dock( FILL )
self.scrollpanel.bg.descbg.desc:DockMargin( 5, 5, 5, 5 )
self.scrollpanel.bg.descbg.desc:SetSize( desX, desY )
self.scrollpanel.bg.descbg.desc:SetFont("CODEXLIST.JobHeader")
self.scrollpanel.bg.descbg.desc:SetTextColor(CODEXLIST.Theme.text.h3)

self.scrollpanel.bg.becomejob = self.scrollpanel.bg:Add("DButton")
self.scrollpanel.bg.becomejob:Dock( LEFT )
self.scrollpanel.bg.becomejob:DockMargin( 5, 5, 5, 5)
self.scrollpanel.bg.becomejob:SetText( "Become job" )
self.scrollpanel.bg.becomejob:SetFont("CODEXLIST.JobHeader")
self.scrollpanel.bg.becomejob.Paint = function(self, w, h)
   surface.SetDrawColor(CODEXLIST.Theme.button)
   surface.DrawRect( 0, 0, 380, h)
   surface.SetDrawColor(CODEXLIST.Theme.button)
   surface.DrawOutlinedRect(0, 380, w, h)
end
self.scrollpanel.bg.becomejob.DoClick = function()
   RunConsoleCommand( "say", "/" ..v.command )
end

self.scrollpanel.bg.jobtitle = self.scrollpanel.bg:Add("DLabel")
self.scrollpanel.bg.jobtitle:SetText( v.name )
self.scrollpanel.bg.jobtitle:Dock( TOP )
self.scrollpanel.bg.jobtitle:DockMargin( 5, 5, 0, 0 )
self.scrollpanel.bg.jobtitle:SetFont("CODEXLIST.JobHeader")
self.scrollpanel.bg.jobtitle:SetTextColor(CODEXLIST.Theme.jobtitle)


if util.IsValidModel(v.model[1]) then
self.scrollpanel.bg.jobmodel = self.scrollpanel.bg:Add("DModelPanel")
		self.scrollpanel.bg.jobmodel:SetSize( 150, 50 )
		self.scrollpanel.bg.jobmodel:Dock( LEFT )
		self.scrollpanel.bg.jobmodel:DockMargin( 5, 5, 5, 5)
		self.scrollpanel.bg.jobmodel:SetModel( v.model[1] )
		self.scrollpanel.bg.jobmodel:SetCamPos( Vector( 20, 0, 65 ) )
		self.scrollpanel.bg.jobmodel:SetLookAt( Vector( 0, 0, 60 ) )
		self.scrollpanel.bg.jobmodel.LayoutEntity = function( ent ) return end
		 else 
self.scrollpanel.bg.jobmodel = self.scrollpanel.bg:Add("DModelPanel")
		self.scrollpanel.bg.jobmodel:SetSize( 150, 50 )
		self.scrollpanel.bg.jobmodel:Dock( LEFT )
		self.scrollpanel.bg.jobmodel:DockMargin( 5, 5, 5, 5)
		self.scrollpanel.bg.jobmodel:SetModel( v.model )
		self.scrollpanel.bg.jobmodel:SetCamPos( Vector( 20, 0, 65 ) )
		self.scrollpanel.bg.jobmodel:SetLookAt( Vector( 0, 0, 60 ) )
		self.scrollpanel.bg.jobmodel.LayoutEntity = function( ent ) return end
end
end
end
function PANEL:Paint()

end


vgui.Register("CODEXLIST.JobsTab", PANEL)