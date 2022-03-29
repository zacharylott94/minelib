-- while these will work with any table, they don't make sense in context.
-- This is strictly for tables that act as lists
local list = {}
list.fold = require("./list/fold")
list.map = require("./list/map")
list.filter = require("./list/filter")

return list