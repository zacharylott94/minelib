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
