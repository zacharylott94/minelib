luacc -o ./portable/list.lua  -i ./lib -i ./lib/list/ list map fold filter
luacc -o ./portable/emptySlots.lua -i ./portable list -i ./lib/trade/ emptySlots -i ./lib id  