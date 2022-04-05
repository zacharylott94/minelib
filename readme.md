Everything in the "portable" folder is bundled and ready to pull into a CC: Tweaked computer using `wget`. You would want to grab the "raw" link for the file. An example:

 ```
 wget https://raw.githubusercontent.com/zacharylott94/minelib/master/portable/list.lua
 ```

 # Looking for something specific?
 ## Item Router
 Install by copying and pasting this into a CC: Tweaked computer: 
 ```
 wget https://raw.githubusercontent.com/zacharylott94/minelib/master/portable/updater_scripts/updateRouter.lua
 ```
 

call the update script from the shell and it will grab the latest version of the item router.
```
updateRouter
```

### Use

#### The software
create a file in the same directory as `router.lua` named `routertable`. `routertable` is in a CSV format. The headers are `destination,source,item,reserve` (you can copy this line directly as your header)
 
Below your header, you list the routes you want items to take. 

Destination and source will both be the names of the peripheral inventories you want to move to and from. They will look something like `minecraft:chest_0`. The easiest way to find this information is to go right click on the router attached to the inventory.

Item is the internal name of the item you want to move. It'll look like `minecraft:stone`.

Reserve is the amount of the item you **want to stay** in the source inventory. The software will not move any items if the amount left is at or below the reserve value. A value of `64` would keep a stack of most items, for example, but this number may be completely arbitrary.

#### routertable example
```
destination,source,item,reserve
minecraft:chest_0,minecraft:chest_1,minecraft:stone,64
minecraft:chest_2,minecraft:chest_1,minecraft:oak_log,64
```
The above table would move stone from `chest_1` to `chest_0` and oak logs from that same chest 1 and send them to `chest_2` while leaving a stack of both items in `chest_0`.

#### The Hardware
You will need a CC: Tweaked computer, some network cable, and a wired modem for each inventory you want to route to. Right click a modem after you set an inventory next to it, and it will tell you the names of the inventories that it has connected to the network. Your computer also needs a modem attach to it.
___
## Fluid Router
Soon:tm:
___

# Where's the rest of the source code? There looks like there's missing libraries...

Correct! I'm new to Lua package management, and moving multiple files onto CC:T computers is a pain. I had to figure out a way to concatenate all of my source files. I'm using Luarocks to install these "portable" packages to my local machine where I can `require` them anywhere. I've failed to publish these packages onto Luarocks because I simply didn't feel like it. The repos do exist here under my profile, though. 

Links for the lazy:

- [csv](https://github.com/zacharylott94/csv)
- [lambda](https://github.com/zacharylott94/lambda)
- [unit](https://github.com/zacharylott94/unit)
- [list](https://github.com/zacharylott94/list)


