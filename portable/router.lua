do
local _ENV = _ENV
package.preload[ "getItemCount" ] = function( ... ) local arg = _G.arg;
do
local _ENV = _ENV
package.preload[ "lambda" ] = function( ... ) local arg = _G.arg;
do
local _ENV = _ENV
package.preload[ "compose" ] = function( ... ) local arg = _G.arg;
return function (f1, f2)
  return function (arg)
    return f2(f1(arg))
  end
end
end
end

do
local _ENV = _ENV
package.preload[ "fnot" ] = function( ... ) local arg = _G.arg;
--because not is a reserved keyword that sorta acts like a function but isn't first class
return function(bool) return not(bool) end
end
end

do
local _ENV = _ENV
package.preload[ "id" ] = function( ... ) local arg = _G.arg;
return function(i) return i end
end
end

do
local _ENV = _ENV
package.preload[ "list" ] = function( ... ) local arg = _G.arg;
do
local _ENV = _ENV
package.preload[ "filter" ] = function( ... ) local arg = _G.arg;
return function(boolFun)
  return function (t)
    local output = {}
    for _, item in pairs(t) do
      if boolFun(item) then table.insert(output,item)
      end
    end
    return output
  end
end
end
end

do
local _ENV = _ENV
package.preload[ "fold" ] = function( ... ) local arg = _G.arg;
return  
  function (fun, start)
    return function (t)
      local output = start
      for _, item in pairs(t) do 
        output = fun(output, item)
      end
      return output
    end
  end
end
end

do
local _ENV = _ENV
package.preload[ "map" ] = function( ... ) local arg = _G.arg;
return  
  function (fun)
    return function (t)
      local output = {}
      for _,item in pairs(t) do
        table.insert(output, fun(item))
      end
      return output
    end
  end
end
end

-- while these will work with any table, they don't make sense in context.
-- This is strictly for tables that act as lists
local list = {}
list.fold = require("fold")
list.map = require("map")
list.filter = require("filter")

return list
end
end

local lambda = {}
local list = require("list")
lambda.id = require("id")
lambda.compose = require("compose")
lambda.combine = list.fold(lambda.compose, lambda.id)
lambda.notf = require("fnot")
lambda.fnot = lambda.notf
lambda.equals = function(val1)
  return function(val2)
    return val1 == val2
  end
end
lambda.andf = function (f1, f2)
  return function (val)
    return f1(val) and f2(val)
  end
end
return lambda
end
end

do
local _ENV = _ENV
package.preload[ "list" ] = function( ... ) local arg = _G.arg;
do
local _ENV = _ENV
package.preload[ "filter" ] = function( ... ) local arg = _G.arg;
return function(boolFun)
  return function (t)
    local output = {}
    for _, item in pairs(t) do
      if boolFun(item) then table.insert(output,item)
      end
    end
    return output
  end
end
end
end

do
local _ENV = _ENV
package.preload[ "fold" ] = function( ... ) local arg = _G.arg;
return  
  function (fun, start)
    return function (t)
      local output = start
      for _, item in pairs(t) do 
        output = fun(output, item)
      end
      return output
    end
  end
end
end

do
local _ENV = _ENV
package.preload[ "map" ] = function( ... ) local arg = _G.arg;
return  
  function (fun)
    return function (t)
      local output = {}
      for _,item in pairs(t) do
        table.insert(output, fun(item))
      end
      return output
    end
  end
end
end

-- while these will work with any table, they don't make sense in context.
-- This is strictly for tables that act as lists
local list = {}
list.fold = require("fold")
list.map = require("map")
list.filter = require("filter")

return list
end
end

local h = require("lambda")
local list = require("list")

local add = function (x,y) return x + y end

local sum = list.fold(add, 0)


local getValue = function (key) return 
  function (t)
    return t[key]
  end
end

local getCount = getValue("count")

local itemHasNameOf = function (name)
  return h.compose(
    getValue("name"),
    h.equals(name)
  )
end


local getItemCount = function (itemName)
  return h.combine({
  list.filter(itemHasNameOf(itemName)),
  list.map(getCount),
  sum,
})
end
  
return getItemCount
end
end

do
local _ENV = _ENV
package.preload[ "itemSlots" ] = function( ... ) local arg = _G.arg;
local itemSlots = function (name, inventory)
  local slots = {}
  for k,v in pairs(inventory) do
    if v.name == name then table.insert(slots,k) end
  end
  return slots
end

return itemSlots
end
end

do
local _ENV = _ENV
package.preload[ "lambda" ] = function( ... ) local arg = _G.arg;
do
local _ENV = _ENV
package.preload[ "compose" ] = function( ... ) local arg = _G.arg;
return function (f1, f2)
  return function (arg)
    return f2(f1(arg))
  end
end
end
end

do
local _ENV = _ENV
package.preload[ "fnot" ] = function( ... ) local arg = _G.arg;
--because not is a reserved keyword that sorta acts like a function but isn't first class
return function(bool) return not(bool) end
end
end

do
local _ENV = _ENV
package.preload[ "id" ] = function( ... ) local arg = _G.arg;
return function(i) return i end
end
end

do
local _ENV = _ENV
package.preload[ "list" ] = function( ... ) local arg = _G.arg;
do
local _ENV = _ENV
package.preload[ "filter" ] = function( ... ) local arg = _G.arg;
return function(boolFun)
  return function (t)
    local output = {}
    for _, item in pairs(t) do
      if boolFun(item) then table.insert(output,item)
      end
    end
    return output
  end
end
end
end

do
local _ENV = _ENV
package.preload[ "fold" ] = function( ... ) local arg = _G.arg;
return  
  function (fun, start)
    return function (t)
      local output = start
      for _, item in pairs(t) do 
        output = fun(output, item)
      end
      return output
    end
  end
end
end

do
local _ENV = _ENV
package.preload[ "map" ] = function( ... ) local arg = _G.arg;
return  
  function (fun)
    return function (t)
      local output = {}
      for _,item in pairs(t) do
        table.insert(output, fun(item))
      end
      return output
    end
  end
end
end

-- while these will work with any table, they don't make sense in context.
-- This is strictly for tables that act as lists
local list = {}
list.fold = require("fold")
list.map = require("map")
list.filter = require("filter")

return list
end
end

local lambda = {}
local list = require("list")
lambda.id = require("id")
lambda.compose = require("compose")
lambda.combine = list.fold(lambda.compose, lambda.id)
lambda.notf = require("fnot")
lambda.fnot = lambda.notf
lambda.equals = function(val1)
  return function(val2)
    return val1 == val2
  end
end
lambda.andf = function (f1, f2)
  return function (val)
    return f1(val) and f2(val)
  end
end
return lambda
end
end

do
local _ENV = _ENV
package.preload[ "list" ] = function( ... ) local arg = _G.arg;
do
local _ENV = _ENV
package.preload[ "filter" ] = function( ... ) local arg = _G.arg;
return function(boolFun)
  return function (t)
    local output = {}
    for _, item in pairs(t) do
      if boolFun(item) then table.insert(output,item)
      end
    end
    return output
  end
end
end
end

do
local _ENV = _ENV
package.preload[ "fold" ] = function( ... ) local arg = _G.arg;
return  
  function (fun, start)
    return function (t)
      local output = start
      for _, item in pairs(t) do 
        output = fun(output, item)
      end
      return output
    end
  end
end
end

do
local _ENV = _ENV
package.preload[ "map" ] = function( ... ) local arg = _G.arg;
return  
  function (fun)
    return function (t)
      local output = {}
      for _,item in pairs(t) do
        table.insert(output, fun(item))
      end
      return output
    end
  end
end
end

-- while these will work with any table, they don't make sense in context.
-- This is strictly for tables that act as lists
local list = {}
list.fold = require("fold")
list.map = require("map")
list.filter = require("filter")

return list
end
end

local csv = require("csv")

local routerTable = io.open("router.csv", "r")

-- {destination,source,item,reserve}[]
local routes = csv.parseh(routerTable)

local wrapSource = function (route) 
  route.source = peripheral.wrap(route.source)
  return route
end

local reserveAsNumber = function (route)
  route.reserve = tonumber(route.reserve)
  return route
end
local list = require("list")
local h = require("lambda")

routes = list.map(h.compose(wrapSource, reserveAsNumber))(routes)

local gic = require("getItemCount")
local itemSlots = require("itemSlots")

local routeOperation = function(route)
  local totalItems = gic(route.item)(route.source.list())
  local difference = totalItems - reserve
  local firstAvailableSlot = itemSlots(route.item,route.source.list())[1]
  if difference > 0 then
    route.source.pushItems(route.source,firstAvailableSlot,difference)
  end

end

while true do
  for _,v in pairs(routes) do
    routeOperation(v)
  end

end
