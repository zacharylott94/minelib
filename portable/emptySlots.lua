do
local _ENV = _ENV
package.preload[ "emptySlots" ] = function( ... ) local arg = _G.arg;
local list = require("list")
local id = require("id")

local filter = list.filter(id)

return function(inventory)
  return inventory.size() - filter(inventory)
end
end
end

do
local _ENV = _ENV
package.preload[ "id" ] = function( ... ) local arg = _G.arg;
return function(i) return i end end
end
end

do
local _ENV = _ENV
package.preload[ "list" ] = function( ... ) local arg = _G.arg;
-- while these will work with any table, they don't make sense in context.
-- This is strictly for tables that act as lists
local list = {}
list.fold = require("./list/fold")
list.map = require("./list/map")
list.filter = require("./list/filter")

return list
end
end

