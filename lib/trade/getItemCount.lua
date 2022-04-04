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