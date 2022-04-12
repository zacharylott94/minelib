Everything in the "portable" folder is bundled and ready to pull into a CC: Tweaked computer using `wget`. You would want to grab the "raw" link for the file. An example:

 ```
 wget https://raw.githubusercontent.com/zacharylott94/minelib/master/portable/example.lua
 ```

 # Looking for something specific?
 ## Item and Fluid Router
 Install by copying and pasting this into a CC: Tweaked computer: 
 ```
 wget https://raw.githubusercontent.com/zacharylott94/minelib/master/portable/updater_scripts/updateRouter.lua
 ```
 

call the update script from the shell and it will grab the latest version of the router.
```
updateRouter
```

### Use

#### The software
create a file in the same directory as `router.lua` named `routertable`. `routertable` is in a CSV format. The headers are `destination,source,item,reserve,limit,type` (you can copy this line directly as your header)
 
Below your header, you list the routes you want items to take. 

Destination and source will both be the names of the peripheral inventories you want to move to and from. They will look something like `minecraft:chest_0`. The easiest way to find this information is to go right click on the router attached to the inventory.

Item is the internal name of the item you want to move. It'll look like `minecraft:stone`.

Reserve is the amount of the item you want to stay in the **source** inventory. The software will not move any items if the amount left is at or below the reserve value. A value of `64` would keep a stack of most items, for example, but this number may be completely arbitrary.

Limit is the amount of the item you want to stay in the **destination** inventory. The software will attempt to keep up to this number of items in the destination of the route. Basically, you can keep the router from flooding an inventory. If you don't want a limit, a limit of 0 will let the router push as much as it can.

##### Fluids

fluids are now supported. To make a route a fluid, simply set the type field to "fluid". Below is what a fluid route looks like:

```
destination,source,item,reserve,limit,type
create:tank_0,create:tank_1,minecraft:water,1000,1000,fluid
```

The above routing table will move water from tank_1 to tank_0, but it will keep a bucket of water in tank_1 and not fill tank_0 past one bucket of water.

#### routertable example
```
destination,source,item,reserve,limit,type
minecraft:chest_0,minecraft:chest_1,minecraft:stone,64,10
minecraft:chest_2,minecraft:chest_1,minecraft:oak_log,64,128
create:tank_0,create:tank_1,minecraft:water,1000,1000,fluid
```
Note that, currently, if the route isn't a fluid and `type` is your last key, you can omit putting anything for the type. 

#### Router Aliases
Aliasing of peripheral names and item names is now possible. Create a file named `routeraliases` in the same directory as `router.lua`. In it, put the alias and the actual peripheral name/ item internal name in pairs on a line. Here's an example:

```
cobble,minecraft:cobblstone
log,minecraft:oak_log
input,minecraft:chest_0
output,minecraft:chest_1
```
you can then use these aliases in a `routertable`

```
destination,source,item,reserve,limit,type
output,input,cobble,0,64
output,input,log,10,10
```

#### The Hardware
You will need a CC: Tweaked computer, some network cable, and a wired modem for each inventory you want to route to. Right click a modem after you set an inventory next to it, and it will tell you the names of the inventories that it has connected to the network. Your computer also needs a modem attach to it.
___


# Where's the rest of the source code? There looks like there's missing libraries...

Correct! I'm new to Lua package management, and moving multiple files onto CC:T computers is a pain. I had to figure out a way to concatenate all of my source files. I'm using Luarocks to install these "portable" packages to my local machine where I can `require` them anywhere. I've failed to publish these packages onto Luarocks because I simply didn't feel like it. The repos do exist here under my profile, though. 

Links for the lazy:

- [csv](https://github.com/zacharylott94/csv)
- [lambda](https://github.com/zacharylott94/lambda)
- [unit](https://github.com/zacharylott94/unit)
- [list](https://github.com/zacharylott94/list)


