if not CLIENT then return end




function CODEXLIST.setPanel( name, icon, sort, func )
    if not name or not icon or not func then return print( "'guthwhitelistsystem.setPanel' should have 3 valid arguments." ) end
    if not isstring( name ) then return print( "'guthwhitelistsystem.setPanel' #1 argument must be a string." ) end
    if not isstring( icon ) then return print( "'guthwhitelistsystem.setPanel' #2 argument must be a string." ) end
    if not isfunction( func ) then return print( "'guthwhitelistsystem.setPanel' #4 argument must be a function." ) end

    table.insert( guthwhitelistsystem.panels, { name = name, func = func, icon = icon, sort = sort or 0 } )

    if sort then
        table.SortByMember( guthwhitelistsystem.panels, "sort", true )
    end
end