require("debugger")

util.AddNetworkString("F4Menu.Open")

    
hook.Add("ShowSpare2", "F4Menu.OpenMenu", function(ply)
net.Start("F4Menu.Open")
net.Send(ply)
end)

util.AddNetworkString("Weapons.Purchase")

net.Receive("Weapons.Purchase", function(len, ply)
  local cat = net.ReadUInt(8)
  local itemId = net.ReadUInt(16)
  local tbl = CODEXLIST.Weapons[cat]
  if (!tbl) then return end
  tbl = tbl.items[itemId]
  if (!tbl) then return end
  local price = tbl.price
  if (!ply:canAfford(price)) then return end
  if (ply:HasWeapon(tbl.ent)) then
    ply:ChatPrint("You already have that weapon!")
	return
   end
   
  ply:addMoney (-price)
  ply:Give(tbl.ent)
  ply:SelectWeapon(tbl.ent)
end)
	


