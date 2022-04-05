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
  local destinationDelta = route.limit - destinationItems
  local firstAvailableSlot = itemSlots(route.item,route.source.list())[1]
  if (sourceDelta > 0) and (destinationDelta > 0) then
    local amount = math.min(sourceDelta, destinationDelta)
    route.source.pushItems(peripheral.getName(route.destination),firstAvailableSlot,amount)
  end

end

while true do
  for _,v in pairs(routes) do
    routeOperation(v)
  end

end
