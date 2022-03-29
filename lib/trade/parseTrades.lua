--parses a csv file that lists out trades
--file format is
--inputItemName,inputAmount,outputItemName,outputAmount 
local tradeFile = io.open("tradelist.csv", "r")


local function parseItem (str)
  local item = {}
  item.name = string.match(str, "(%w+:%w+)")
  item.count = string.match(str, "%d+")
  return item
end

local function parse(line)
  local trade = {}
  --separate line into itemname,quantity substrings
  for each in string.gmatch(line, "(%w+:%w,%d+)") do
    -- parse each substring into an Item table
    local item = parseItem(each)
    table.insert(trade, item)
  end
  return trade

end


for line in tradeFile:lines() do
  print(parse(line))
end