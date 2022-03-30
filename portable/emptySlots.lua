
---------------------------------------------------------
----------------Auto generated code block----------------
---------------------------------------------------------

do
    local searchers = package.searchers or package.loaders
    local origin_seacher = searchers[2]
    searchers[2] = function(path)
        local files =
        {
------------------------
-- Modules part begin --
------------------------

["emptySlots"] = function()
--------------------
-- Module: 'emptySlots'
--------------------

---------------------------------------------------------
----------------Auto generated code block----------------
---------------------------------------------------------

do
    local searchers = package.searchers or package.loaders
    local origin_seacher = searchers[2]
    searchers[2] = function(path)
        local files =
        {
------------------------
-- Modules part begin --
------------------------

["id"] = function()
--------------------
-- Module: 'id'
--------------------
return function(i) return i end end
end,

["list"] = function()
--------------------
-- Module: 'list'
--------------------
-- while these will work with any table, they don't make sense in context.
-- This is strictly for tables that act as lists
local list = {}
list.fold = require("./list/fold")
list.map = require("./list/map")
list.filter = require("./list/filter")

return list
end,

----------------------
-- Modules part end --
----------------------
        }
        if files[path] then
            return files[path]
        else
            return origin_seacher(path)
        end
    end
end
---------------------------------------------------------
----------------Auto generated code block----------------
---------------------------------------------------------
local list = require("list")
local id = require("id")

local filter = list.filter(id)

return function(inventory)
  return inventory.size() - filter(inventory)
end
end,

["id"] = function()
--------------------
-- Module: 'id'
--------------------
return function(i) return i end end
end,

----------------------
-- Modules part end --
----------------------
        }
        if files[path] then
            return files[path]
        else
            return origin_seacher(path)
        end
    end
end
---------------------------------------------------------
----------------Auto generated code block----------------
---------------------------------------------------------

---------------------------------------------------------
----------------Auto generated code block----------------
---------------------------------------------------------

do
    local searchers = package.searchers or package.loaders
    local origin_seacher = searchers[2]
    searchers[2] = function(path)
        local files =
        {
------------------------
-- Modules part begin --
------------------------

["map"] = function()
--------------------
-- Module: 'map'
--------------------
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

end,

["fold"] = function()
--------------------
-- Module: 'fold'
--------------------
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

end,

["filter"] = function()
--------------------
-- Module: 'filter'
--------------------
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

end,

----------------------
-- Modules part end --
----------------------
        }
        if files[path] then
            return files[path]
        else
            return origin_seacher(path)
        end
    end
end
---------------------------------------------------------
----------------Auto generated code block----------------
---------------------------------------------------------
-- while these will work with any table, they don't make sense in context.
-- This is strictly for tables that act as lists
local list = {}
list.fold = require("./list/fold")
list.map = require("./list/map")
list.filter = require("./list/filter")

return list