local csv = require("csv")

local routerTable = io.open("routertable", "r")

-- {destination,source,item,reserve,limit}[]
local routes = csv.parseh(routerTable)

local convertRawRoute = function (route)
  route.source = peripheral.wrap(route.source)
  route.destination = peripheral.wrap(route.destination)
  route.reserve = tonumber(route.reserve)
  route.limit = tonumber(route.limit)
end

local list = require("list")
routes = list.map(convertRawRoute)(routes)

local gic = require("getItemCount")
local itemSlots = require("itemSlots")

local routeOperation = function(route)
  local sourceItems = gic(route.item)(route.source.list())
  local destinationItems = gic(route.item)(route.destination.list())
  local sourceDelta = sourceItems - route.reserve
  local destinationDelta 
  local amount
  if (route.limit == 0) then
    destinationDelta = 1
    amount = sourceDelta
  elseif (route.limit > 0) then
    destinationDelta = route.limit - destinationItems
    amount = math.min(sourceDelta, destinationDelta)
  else --if limit is negative, fail
    return false
  end
  local firstAvailableSlot = itemSlots(route.item,route.source.list())[1]
  if (sourceDelta > 0) and (destinationDelta > 0) then
    route.source.pushItems(peripheral.getName(route.destination),firstAvailableSlot,amount)
    return true
  end
  return false
end

while true do
  local success = false
  for _,v in pairs(routes) do
    if routeOperation(v) then success = true end
  end
  if not success then sleep(5) end
end
