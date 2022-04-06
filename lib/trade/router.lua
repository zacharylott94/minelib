local csv = require("csv")

local routerTable = io.open("routertable", "r")

-- {destination,source,item,reserve,limit}[]
local routes = csv.parseh(routerTable)

local convertRawRoute = function (route)
  route.source = peripheral.wrap(route.source)
  route.destination = peripheral.wrap(route.destination)
  route.reserve = tonumber(route.reserve)
  route.limit = tonumber(route.limit)
  return route
end

local list = require("list")
routes = list.map(convertRawRoute)(routes)

local gic = require("getItemCount")
local itemSlots = require("itemSlots")

local itemRouteOperation = function(route)
  local sourceItems = gic(route.item)(route.source.list())
  local destinationItems = gic(route.item)(route.destination.list())
  local sourceDelta = sourceItems - route.reserve
  local amount
  if (route.limit == 0) then
    amount = sourceDelta
  elseif (route.limit > 0) then
    local destinationDelta = route.limit - destinationItems
    amount = math.min(sourceDelta, destinationDelta)
  else --if limit is negative, fail
    return false
  end
  local firstAvailableSlot = itemSlots(route.item,route.source.list())[1]
  if (amount > 0) then
    route.source.pushItems(peripheral.getName(route.destination),firstAvailableSlot,amount)
    return true
  end
  return false
end

local fluidRouteOperation = function(route)
  local amount = 1000
  if (amount > 0) then
    route.source.pushFluid(peripheral.getName(route.destination), amount, route.item)
    return true
  end
  return false
end

local isFluidRoute = function(route)
  return peripheral.hasType(route.source,"fluid_storage")
end

while true do
  local success = false
  for _,v in pairs(routes) do
    if isFluidRoute(v) then 
      if fluidRouteOperation(v) then success = true end
    else
      if itemRouteOperation(v) then success = true end
  end
  if not success then sleep(5) end
end
