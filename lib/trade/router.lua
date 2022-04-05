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
