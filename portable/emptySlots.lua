package.preload[ "emptySlots" ] = assert( (loadstring or load)( "local list = require(\"list\")\
local id = require(\"id\")\
\
local filter = list.filter(id)\
\
return function(inventory)\
  return inventory.size() - filter(inventory)\
end", '@'.."./lib/trade/emptySlots.lua" ) )

package.preload[ "id" ] = assert( (loadstring or load)( "return function(i) return i end", '@'.."./lib/id.lua" ) )

package.preload[ "list" ] = assert( (loadstring or load)( "-- while these will work with any table, they don't make sense in context.\
-- This is strictly for tables that act as lists\
local list = {}\
list.fold = require(\"./list/fold\")\
list.map = require(\"./list/map\")\
list.filter = require(\"./list/filter\")\
\
return list", '@'.."./lib/list.lua" ) )

