require("unit")



local EmptySlots = Unit.suite("EmptySlots", {
  

  Unit.test("returns a number of empty slots", function()
    local es = require("lib/trade/emptySlots")
    local mockInventorySlots = {
      nil,
      nil,
      1,
      nil,
      2,
      3,
      4,
      nil,
      nil,
      nil,
      5,
      6,
      7
    }
    
    local mockInventory = {}
    mockInventory.list = function () return mockInventorySlots end
    mockInventory.size = function () return 13 end
    local actual = es(mockInventory)
    return {
      Unit.equals(actual,6)
    }
  
  end)
  
})

Unit.report(EmptySlots)


local getItemCount = Unit.suite("getItemCount", {
  

  Unit.test("returns the total number of a given item in an inventory", function()
    local gic = require("lib/trade/getItemCount")
    local mockInventory = {
      {name = "one", count = 1},
      {name = "one", count = 1},
      nil,
      nil,
      {name = "two", count = 3},
      nil,
      nil,
    }
    
    local actual = gic("one")(mockInventory)
    return {
      Unit.equals(actual,2),
      Unit.equals(gic("two")(mockInventory), 3)
    }
  
  end)
  
})

Unit.report(getItemCount)