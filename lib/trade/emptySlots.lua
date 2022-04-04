local list = require("list")
local id = require("lambda").id

local filter = list.filter(id)

return function(inventory)
  return (inventory.size() - #filter(inventory.list()))
end