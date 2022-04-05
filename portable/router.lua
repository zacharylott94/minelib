do
local _ENV = _ENV
package.preload[ "csv" ] = function( ... ) local arg = _G.arg;

--helper functions
local split = function(str, char)
  local lasti = 1
  local subs = {}
  for i = 1, #str, 1 do
    local c = str:sub(i,i)
    if (char == c) then 
      table.insert(subs, string.sub(str, lasti, i-1))
      lasti = i +1
    end
  end
  table.insert(subs, string.sub(str, lasti))
  return subs
end


-- expects tables of equal length
local function zip (t1, t2)
  local zipped = {}
  for k,v in pairs(t1) do
    zipped[v] = t2[k]
  end
  return zipped
end


----------------


-- parses, treating first line the same as other lines
local function parse(file)
  local tab = {}
  for line in file:lines() do
    table.insert(tab, split(line, ","))
  end
  return tab

end

--parses, treating the first line as table keys
local function parseh(file)
  local tab = {}
  local headers = split(file:read(), ",")
  for line in file:lines() do
    local values = split(line, ",")
    table.insert(tab, zip(headers, values))
  end
  return tab

end

return {
  split = split, --expose only for testing
  parse = parse,
  parseh = parseh
}
end
end

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

local routerTable = io.open("routertable", "r")

-- {destination,source,item,reserve,limit}[]
local routes = csv.parseh(routerTable)

local wrapPeripherals = function (route) 
  route.source = peripheral.wrap(route.source)
  route.destination = peripheral.wrap(route.destination)
  return route
end

local convertNumbers = function (route)
  route.reserve = tonumber(route.reserve)
  route.limit = tonumber(route.limit)
  return route
end
local list = require("list")
local h = require("lambda")

routes = list.map(h.compose(wrapPeripherals, convertNumbers))(routes)

local gic = require("getItemCount")
local itemSlots = require("itemSlots")

local routeOperation = function(route)
  local sourceItems = gic(route.item)(route.source.list())
  local destinationItems = gic(route.item)(route.destination.list())
  local sourceDelta = sourceItems - route.reserve
  local destinationDelta 
  if (route.limit == 0) then
    destinationDelta = 1
  else
    destinationDelta = route.limit - destinationItems
  end
  local firstAvailableSlot = itemSlots(route.item,route.source.list())[1]
  if (sourceDelta > 0) and (destinationDelta > 0) then
    local amount
    if (route.limit > 0) then
      amount = math.min(sourceDelta, destinationDelta)
    else
      amount = sourceDelta
    end
      route.source.pushItems(peripheral.getName(route.destination),firstAvailableSlot,amount)
    return true, amount
  end
  return false
end

while true do
  for _,v in pairs(routes) do
    local success, amount = routeOperation(v)
    if success then
      local destination = peripheral.getName(v.destination)
      local source = peripheral.getName(v.source)
      print(string.format("Pushed %s %s from %s to %s", amount, v.item, source, destination))
    end
  end
end
