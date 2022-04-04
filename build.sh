amalg.lua -o ./portable/emptySlots.lua -s ./lib/trade/emptySlots.lua lambda list
amalg.lua -o ./portable/getItemCount.lua -s ./lib/trade/getItemCount.lua list lambda
LUA_PATH="$LUA_PATH;./portable/?.lua;;" amalg.lua -o ./portable/router.lua -s ./lib/trade/router.lua list lambda itemSlots getItemCount csv