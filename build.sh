LUA_PATH="./lib/?.lua;./lib/list/?.lua;;" amalg.lua -o ./portable/list.lua  list map fold filter
LUA_PATH="./lib/?.lua;./lib/trade/?.lua;./portable/?.lua;;" amalg.lua -o ./portable/emptySlots.lua emptySlots id list
#luacc -o ./portable/emptySlots.lua -i ./portable list -i ./lib/trade/ emptySlots -i ./lib id  