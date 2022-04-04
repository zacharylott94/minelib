local itemSlots = function (name, inventory)
  local slots = {}
  for k,v in pairs(inventory) do
    if v.name == name then table.insert(slots,k) end
  end
  return slots
end

return itemSlots