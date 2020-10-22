local PANEL = {}

local matplayericon = Material("materials/playericon.png")
local mateconomyicon = Material("materials/economy.png")
local matjobicon = Material("materials/jobs.png")

AccessorFunc(PANEL, "m_body", "Body")

CODEXLIST:CreateFont("CommandPanel", 18)


function PANEL:Init()

  self.mainbackground = self:Add("DPanel")
  self.mainbackground:Dock( FILL )
  self.mainbackground.Paint = function (self, w, h)
     draw.RoundedBoxEx(6, 0, 0, w, h, CODEXLIST.Theme.background, true, true, false, false)

  end
  
  self.mainbackground.staffbg = self.mainbackground:Add("Panel")
  self.mainbackground.staffbg:SetSize( 160, 190 )
  self.mainbackground.staffbg:SetPos( 640, 10 )
  self.mainbackground.staffbg.Paint = function (self, w, h)
      draw.RoundedBoxEx( 2, 0, 0, w, h, CODEXLIST.Theme.primary, false, true, true, true )
	  draw.RoundedBoxEx( 2, 1, 1, w - 30, h - 2, CODEXLIST.Theme.primary, false, true, true, true)
	  
	  draw.SimpleText( "Staff Online", "CODEXLIST.CommandPanel", 24, 10, CODEXLIST.Theme.text.h1)
	  
	  surface.SetDrawColor( Color( 242, 242, 242 ))
	  surface.DrawLine( 24, 34, 85, 34 )
end
  
  self.mainbackground.staffbg.stafflist = self.mainbackground.staffbg:Add("DPanelList")
  self.mainbackground.staffbg.stafflist:SetSize(132, 140)
  self.mainbackground.staffbg.stafflist:SetPos(24, 50)
  self.mainbackground.staffbg.stafflist:SetSpacing( 0.5 )
  self.mainbackground.staffbg.stafflist:EnableVerticalScrollbar( true )
  self.mainbackground.staffbg.stafflist.Paint = function (self, w, h)
     draw.RoundedBoxEx( 3, 0, 0, w, h+50, CODEXLIST.Theme.primary, false, true, true, true)
  end
	self.mainbackground.staffbg.stafflist.VBar.btnUp.Paint = function( self, w, h ) end
	self.mainbackground.staffbg.stafflist.VBar.btnDown.Paint = function( self, w, h ) end
	self.mainbackground.staffbg.stafflist.VBar.btnGrip.Paint = function( self, w, h )
		draw.RoundedBox( 4, 5, 0, 4, h+22, Color(0,0,0,70))
	end

    for k, v in pairs( player.GetAll() ) do
	   if table.HasValue( CODEXLIST.Config.staffListRanks, v:GetUserGroup()) then
	   self.mainbackground.playerlist = self.mainbackground:Add("Panel")
	   self.mainbackground.playerlist:Dock( BOTTOM )
	   self.mainbackground.playerlist:SetSize(132, 75)
	   self.mainbackground.playerlist.Paint = function(self, w, h)
	   	--draw.SimpleText( string.upper(v:Name()), "CODEXLIST.CommandPanel", 40, 12 - 6, CODEXLIST.Theme.text.h1 )
		--draw.SimpleText( string.upper(v:GetUserGroup()), "CODEXLIST.CommandPanel", 40, 26 - 6, CODEXLIST.Theme.text.h1 )
	   end
	   
	   self.mainbackground.playerlist.playerlabel = self.mainbackground.playerlist:Add("DLabel")
	   self.mainbackground.playerlist.playerlabel:SetSize( 128, 20)
	   self.mainbackground.playerlist.playerlabel:SetPos(0, 0)
	   self.mainbackground.playerlist.playerlabel:SetFont("CODEXLIST.CommandPanel")
	   self.mainbackground.playerlist.playerlabel:SetText( string.upper(v:Nick()))
	   self.mainbackground.playerlist.playerlabel:SetTextColor(CODEXLIST.Theme.button)
	   
	   self.mainbackground.playerlist.playerlabel = self.mainbackground.playerlist:Add("DLabel")
	   self.mainbackground.playerlist.playerlabel:SetSize( 128, 20)
	   self.mainbackground.playerlist.playerlabel:SetPos(0, 50)
	   self.mainbackground.playerlist.playerlabel:SetFont("CODEXLIST.CommandPanel")
	   self.mainbackground.playerlist.playerlabel:SetText( string.upper(v:GetUserGroup()))
	   self.mainbackground.playerlist.playerlabel:SetTextColor(CODEXLIST.Theme.text.h1)

       self.mainbackground.playerlist.playeravatar = self.mainbackground.playerlist:Add("AvatarImage")
	   self.mainbackground.playerlist.playeravatar:SetSize(32, 32)
	   self.mainbackground.playerlist.playeravatar:SetPos(0, 20)
	   self.mainbackground.playerlist.playeravatar:SetPlayer( v, 32 )
	   
	   self.mainbackground.staffbg.stafflist:AddItem(self.mainbackground.playerlist)
	   end
	   end
	
  self.mainbackground.buttonpanel = self.mainbackground:Add("Panel")
  self.mainbackground.buttonpanel:Dock( BOTTOM )
  self.mainbackground.buttonpanel:DockMargin( 5, 5, 5, 5)
  self.mainbackground.buttonpanel:SetSize(150, 220)
  self.mainbackground.buttonpanel.Paint = function(pnl, w, h)
	   draw.RoundedBoxEx( 2, 0, 0, w, h, CODEXLIST.Theme.primary, true, true, true, true)
	   
	   end
   
   self.mainbackground.buttonpanel.title = self.mainbackground.buttonpanel:Add("DLabel")
   self.mainbackground.buttonpanel.title:SetText("Commands")
   self.mainbackground.buttonpanel.title:Dock( TOP )
   self.mainbackground.buttonpanel.title:DockMargin( 5, 5, 0, 0 )
   self.mainbackground.buttonpanel.title:SetFont("CODEXLIST.CommandPanel")
   self.mainbackground.buttonpanel.title:SetTextColor(CODEXLIST.Theme.text.h1)

   local overallMoney = 0
   local capBase = 0
   local money = 0
   
   local maxBase = 0
   
   local jobs = {}
   
   for k, v in pairs ( player.GetAll() ) do
   local vMoney = v:getDarkRPVar ("money") or 0
   money = money + vMoney
   end
   
   local moneyTable = {}
   
   for k, v in pairs ( player.GetAll() ) do
      table.insert (moneyTable, { ply = v, money = v:getDarkRPVar( "money" ) or 0 } )
   end
   
   for k, v in pairs ( team.GetAllTeams() ) do
      if team.NumPlayers( k ) > 0 then
	    table.insert( jobs, v )
	  end
   end
   
   table.SortByMember( moneyTable, "money" )
   
   local first = table.GetFirstValue( moneyTable )
   
   local jobTable = team.GetAllTeams()
   
   local teamTable = {}
   
   for k, v in pairs( jobTable ) do
      if v.Name != "Joining/Connecting" then
	  
	  local numPlayers = team.NumPlayers( k )
	  
	  teamTable[k] = numPlayers
	  
	 end
end

local maxPlayers = table.Count ( player.GetAll() )

self.mainbackground.stats = self.mainbackground:Add("Panel")
self.mainbackground.stats:SetSize( 600, 200 )
self.mainbackground.stats:Dock(LEFT)

self.mainbackground.stats.Paint = function( self, w, h )
    draw.RoundedBoxEx( 2, 10, 10, w, h, CODEXLIST.Theme.primary, false, false, false, false)
	draw.RoundedBoxEx( 2, 10, 10, w, h, CODEXLIST.Theme.primary, false, false, false, false)
	
	draw.SimpleText( "Server Statistics", "CODEXLIST.CommandPanel", 40, 10, CODEXLIST.Theme.text.h1)

    surface.SetDrawColor(CODEXLIST.Theme.text.h1)
	
	surface.DrawLine( 130, 30, 40, 30 )
	

	
	surface.SetDrawColor( Color( 152, 152, 219 ) )
	surface.SetMaterial(matplayericon)
	surface.DrawTexturedRect( 45, 55, 25, 38 )
	
	draw.SimpleText( "PLAYERS", "CODEXLIST.CommandPanel", 38, 36, CODEXLIST.Theme.text.h1)
	draw.SimpleText("PLAYERS ONLINE: "..maxPlayers, "CODEXLIST.CommandPanel", 18,  100, CODEXLIST.Theme.text.h1)

    surface.SetDrawColor( Color( 152, 152, 219 ) )
	surface.SetMaterial(mateconomyicon)
	surface.DrawTexturedRect( 160, 65, 40, 40 )
	
	draw.SimpleText( "ECONOMY", "CODEXLIST.CommandPanel", 155, 46, CODEXLIST.Theme.text.h1)
	
	if overallMoney != money then
	  overallMoney = Lerp( FrameTime() * 5, overallMoney, money )
	end
	
	if capBasee != first.money then
	  capBase = Lerp( FrameTime() * 5, capBase, first.money)
	  
	local overMoney = string.Comma(math.ceil(overallMoney)) or "Error loading economical stats"
	local capMoney = string.Comma(math.ceil( capBase )) or "Error loading economical stats"

    draw.SimpleText("ALL EXISTING MONEY $"..overMoney, "CODEXLIST.CommandPanel", 125, 112, CODEXLIST.Theme.text.h1)
	draw.SimpleText(string.upper(first.ply:Nick()).." IS THE RICHEST $"..capMoney, "CODEXLIST.CommandPanel", 125, 132, CODEXLIST.Theme.text.h1)
  
    surface.SetDrawColor( Color( 211, 50, 24 ) )
	surface.SetMaterial(matjobicon)
	surface.DrawTexturedRect( 315, 68, 36, 36 )
	
	draw.SimpleText( "EMLPOYMENT", "CODEXLIST.CommandPanel", 303, 49, CODEXLIST.Theme.text.h1)
	
	draw.SimpleText ("UTILIZED JOBS: "..table.Count( jobs ), "CODEXLIST.CommandPanel", 303, 108, CODEXLIST.Theme.h1)
    draw.SimpleText( "MOST POPULAR JOB: "..string.upper(team.GetName(table.GetWinningKey( teamTable ) )).. " ("..team.NumPlayers(table.GetWinningKey( teamTable )).." players)", "CODEXLIST.CommandPanel", 303, 128, CODEXLIST.Theme.text.h1)
  end
  end
  
  
  function self.mainbackground.buttonpanel.button1( text, func )
  self.mainbackground.buttonpanel.button1 = self.mainbackground.buttonpanel:Add("DButton")
  self.mainbackground.buttonpanel.button1:SetText( text )
  self.mainbackground.buttonpanel.button1:SetFont("CODEXLIST.CommandPanel")
  self.mainbackground.buttonpanel.button1:Dock( BOTTOM )
  self.mainbackground.buttonpanel.button1:DockMargin( 5, 5, 5, 5 )
  self.mainbackground.buttonpanel.button1.Paint = function( self, w, h )
      surface.SetDrawColor(CODEXLIST.Theme.button)
	  surface.DrawRect( 0, 0, w, h )
	   surface.SetDrawColor(CODEXLIST.Theme.button)
	  surface.DrawRect( 0, 0, w, h )
end
  self.mainbackground.buttonpanel.button1.DoClick = func 
end
 function self.mainbackground.buttonpanel.button2( text, func )
  self.mainbackground.buttonpanel.button2 = self.mainbackground.buttonpanel:Add("DButton")
  self.mainbackground.buttonpanel.button2:SetText( text )
  self.mainbackground.buttonpanel.button2:SetFont("CODEXLIST.CommandPanel")
  self.mainbackground.buttonpanel.button2:Dock( TOP )
  self.mainbackground.buttonpanel.button2:DockMargin( 5, 5, 5, 5 )
  self.mainbackground.buttonpanel.button2.Paint = function( self, w, h )
      surface.SetDrawColor(CODEXLIST.Theme.button)
	  surface.DrawRect( 0, 0, w, h )
	   surface.SetDrawColor(CODEXLIST.Theme.button)
	  surface.DrawRect( 0, 0, w, h )
end
  self.mainbackground.buttonpanel.button2.DoClick = func 
end
 function self.mainbackground.buttonpanel.button3( text, func )
  self.mainbackground.buttonpanel.button3 = self.mainbackground.buttonpanel:Add("DButton")
  self.mainbackground.buttonpanel.button3:SetText( text )
  self.mainbackground.buttonpanel.button3:SetFont("CODEXLIST.CommandPanel")
  self.mainbackground.buttonpanel.button3:Dock( TOP )
  self.mainbackground.buttonpanel.button3:DockMargin( 5, 5, 5, 5 )
  self.mainbackground.buttonpanel.button3.Paint = function( self, w, h )
      surface.SetDrawColor(CODEXLIST.Theme.button)
	  surface.DrawRect( 0, 0, w, h )
	   surface.SetDrawColor(CODEXLIST.Theme.button)
	  surface.DrawRect( 0, 0, w, h )
end
  self.mainbackground.buttonpanel.button3.DoClick = func 
end
 function self.mainbackground.buttonpanel.button4( text, func )
  self.mainbackground.buttonpanel.button4 = self.mainbackground.buttonpanel:Add("DButton")
  self.mainbackground.buttonpanel.button4:SetText( text )
  self.mainbackground.buttonpanel.button4:SetFont("CODEXLIST.CommandPanel")
  self.mainbackground.buttonpanel.button4:Dock( TOP )
  self.mainbackground.buttonpanel.button4:DockMargin( 5, 5, 5, 5 )
  self.mainbackground.buttonpanel.button4.Paint = function( self, w, h )
      surface.SetDrawColor(CODEXLIST.Theme.button)
	  surface.DrawRect( 0, 0, w, h )
	   surface.SetDrawColor(CODEXLIST.Theme.button)
	  surface.DrawRect( 0, 0, w, h )
end
  self.mainbackground.buttonpanel.button4.DoClick = func 
end
 function self.mainbackground.buttonpanel.button5( text, func )
  self.mainbackground.buttonpanel.button5 = self.mainbackground.buttonpanel:Add("DButton")
  self.mainbackground.buttonpanel.button5:SetText( text )
  self.mainbackground.buttonpanel.button5:SetFont("CODEXLIST.CommandPanel")
  self.mainbackground.buttonpanel.button5:Dock( TOP )
  self.mainbackground.buttonpanel.button5:DockMargin( 5, 5, 5, 5 )
  self.mainbackground.buttonpanel.button5.Paint = function( self, w, h )
      surface.SetDrawColor(CODEXLIST.Theme.button)
	  surface.DrawRect( 0, 0, w, h )
	   surface.SetDrawColor(CODEXLIST.Theme.button)
	  surface.DrawRect( 0, 0, w, h )
end
  self.mainbackground.buttonpanel.button5.DoClick = func 
end
 function self.mainbackground.buttonpanel.button6( text, func )
  self.mainbackground.buttonpanel.button6 = self.mainbackground.buttonpanel:Add("DButton")
  self.mainbackground.buttonpanel.button6:SetText( text )
  self.mainbackground.buttonpanel.button6:SetFont("CODEXLIST.CommandPanel")
  self.mainbackground.buttonpanel.button6:Dock( TOP )
  self.mainbackground.buttonpanel.button6:DockMargin( 5, 5, 5, 5 )
  self.mainbackground.buttonpanel.button6.Paint = function( self, w, h )
      surface.SetDrawColor(CODEXLIST.Theme.button)
	  surface.DrawRect( 0, 0, w, h )
	   surface.SetDrawColor(CODEXLIST.Theme.button)
	  surface.DrawRect( 0, 0, w, h )
end
  self.mainbackground.buttonpanel.button6.DoClick = func 
end
self.mainbackground.buttonpanel.button1( "Give money to (looking at)", function() 
      Derma_StringRequest( "Give Money", "How much?", "", function( txt )
	  RunConsoleCommand( "say", "/give " .. txt )
	  end)
end )
self.mainbackground.buttonpanel.button2( "Drop Money", function()
      Derma_StringRequest( "Drop money", "How much?", "", function( txt )
      RunConsoleCommand( "say", "/dropmoney " .. txt )
	  end)
end )
self.mainbackground.buttonpanel.button3( "Call an admin", function()
      RunConsoleCommand( "say", "@ I need help" )
	  end)
self.mainbackground.buttonpanel.button4( "Change your RPName", function()
      Derma_StringRequest( "RPName", "What´s your new name?", "", function( txt )
      RunConsoleCommand( "say", "/rpname " .. txt )
	  end)
end )
self.mainbackground.buttonpanel.button5( "Change your job title", function()
      Derma_StringRequest( "Job", "What is the new name of your job?", "", function( txt )
      RunConsoleCommand( "say", "/job " .. txt )
	  end)
end )
self.mainbackground.buttonpanel.button6( "Anti-Stuck (suicide)", function()
      Derma_StringRequest( "Anti-Stuck (suicide)", "Press OK to suicide. (Will kill you if server has it enabled)", "", function( txt )
      RunConsoleCommand( "kill" )
	  end)
end )
end
function PANEL:Paint()

end


vgui.Register("CODEXLIST.Dashboard", PANEL)