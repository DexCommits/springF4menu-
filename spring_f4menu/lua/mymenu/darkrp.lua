local function OverrideDarkRPMenu()
    function DarkRP.openMenu() end
end

if (DarkRP) then
   OverrideDarkRPMenu()
else
   hook.Add("DarkRPFinishedLoading", "F4Menu.OverrideItemLimit", OverrideDarkRPMenu)
end