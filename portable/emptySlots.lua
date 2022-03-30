package.preload[ "emptySlots" ] = assert( (loadstring or load)( "", '@'.."./portable/emptySlots.lua" ) )

package.preload[ "id" ] = assert( (loadstring or load)( "return function(i) return i end", '@'.."./lib/id.lua" ) )

package.preload[ "list" ] = assert( (loadstring or load)( "do\
local _ENV = _ENV\
package.preload[ \"filter\" ] = function( ... ) local arg = _G.arg;\
return function(boolFun)\
  return function (t)\
    local output = {}\
    for _, item in pairs(t) do\
      if boolFun(item) then table.insert(output,item)\
      end\
    end\
    return output\
  end\
end\
end\
end\
\
do\
local _ENV = _ENV\
package.preload[ \"fold\" ] = function( ... ) local arg = _G.arg;\
return  \
  function (fun, start)\
    return function (t)\
      local output = start\
      for _, item in pairs(t) do \
        output = fun(output, item)\
      end\
      return output\
    end\
  end\
end\
end\
\
do\
local _ENV = _ENV\
package.preload[ \"map\" ] = function( ... ) local arg = _G.arg;\
return  \
  function (fun)\
    return function (t)\
      local output = {}\
      for _,item in pairs(t) do\
        table.insert(output, fun(item))\
      end\
      return output\
    end\
  end\
end\
end\
\
-- while these will work with any table, they don't make sense in context.\
-- This is strictly for tables that act as lists\
local list = {}\
list.fold = require(\"./list/fold\")\
list.map = require(\"./list/map\")\
list.filter = require(\"./list/filter\")\
\
return list", '@'.."./portable/list.lua" ) )

