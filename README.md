# Cyb3r-Robbing
A custom script for roleplay servers that allows the specification of which items or cash which could be robbed from the player.

### Screenshot Previews - In a few screenshots I am using a modified version of qb-menu which doesn't show Item Images/Icons but With the Original one, you will be able to see them
![image](https://media.discordapp.net/attachments/1213222011170717706/1252421091125891163/Screenshot_430.png?ex=66722788&is=6670d608&hm=9b137ce95220e5717428bbcb63d1313824da4bf0aeff14e658e81b404845aba8&=&format=webp&quality=lossless&width=1193&height=671)
![image](https://media.discordapp.net/attachments/1213222011170717706/1252421092065284177/Screenshot_431.png?ex=66722789&is=6670d609&hm=76439cda76b50a64e43ccc58f3c6a899a2518462fc0d2de98c239ebce477f144&=&format=webp&quality=lossless&width=1193&height=671)
![image](https://cdn.discordapp.com/attachments/1213222011170717706/1252421092744892497/Screenshot_432.png?ex=66722789&is=6670d609&hm=fc81f8a2cb808f77b92c2aa583a725d6f907b30d9020bdf8e408174b8f0fabc8&)
![image](https://cdn.discordapp.com/attachments/1213222011170717706/1252421095139709010/Screenshot_433.png?ex=66722789&is=6670d609&hm=57123299f03180b7b4a2075c79252862534e72fe1acc708fd99e3374e4ffc285&)
![image](https://cdn.discordapp.com/attachments/1213222011170717706/1253423768706093078/Screenshot_443.png?ex=6675cd59&is=66747bd9&hm=f95804f59dddc39a3c68f245b03897e0c34581527047756505add136b9606b86&)
![image](https://cdn.discordapp.com/attachments/1213222011170717706/1253423770329288835/Screenshot_445.png?ex=6675cd5a&is=66747bda&hm=0bdf51d95dbfbcf65a981c53a05dd00ab22e8ed0ccf829129a7579a0c3e9599e&)
![image](https://cdn.discordapp.com/attachments/1213222011170717706/1253423769423188081/Screenshot_444.png?ex=6675cd5a&is=66747bda&hm=a0534f5567132d8444c39fdda8005ed6cc21dacd9ccd7378cfe2c3179d69c073&)
![image](https://cdn.discordapp.com/attachments/1213222011170717706/1253423770954109041/Screenshot_446.png?ex=6675cd5a&is=66747bda&hm=b580147ce224c811ced09aee834b0e97f2d3edb561883a0189232fea5b6c894c&)
![image](https://cdn.discordapp.com/attachments/1213222011170717706/1252424125792649276/image.png?ex=66722a5c&is=6670d8dc&hm=fe2a341afffd4582cadf3685727717769d5c0de389d1a4625724944c13ce1fec&)
![image](https://cdn.discordapp.com/attachments/1213222011170717706/1252424329568849982/image.png?ex=66722a8d&is=6670d90d&hm=8a023528bcdc3963264252ff34c89ab5b28914db3d2b3897106400f5600b1e5c&)

## Dependencies
- rpemotes - For The Emotes that will play while searching the player
- qb-menu (Optional) - For The Robbing Menu
- ox_lib - For Robbing menu, if you don't want to use qb-menu
- progressbar - For the progressbar while searching the person

# How to install

- Place the folder in your resources folder
- add the following code to your server.cfg file

```
ensure Cyb3r-robbing
```
### Installation

- Add the image to your inventory folder
- add the follwing line into your `items.lua`

```lua
-- Cyb3r-Robbing Items
robbingkit = { name = 'robbingkit', label = 'Robbery Kit', weight = 1000, type = 'item', image = 'robbingkit.png', unique = true, useable = true, shouldClose = true, description = 'A Robbery Kit that can be used to search people' },
```

# Features:
### Update v1.1.0
- Added support for ox_lib context menu, incase you don't want to use qb menu
- Added Cash Rob Max Amount for players
- Added Cash Rob Cooldown, will disable option to rob cash after Max Amount is robbed (Configurable)
- Changed from qb-logs to inbuilt log system, just configure your webhookurl
- Added Max Stealable Items Limit, to limit players from robbing certain items 
- Added Cooldown For Max Stealable Items Limit, will disable option to rob that specific item after Max Amount is robbed (Configurable)
- Some Additional Bug Fixes

### Robbing Config
- Configurable Items: Easily edit the items that can be robbed in the config.lua file.
- Enable/Disable Options: Toggle item robbery and cash robbery on or off in the config.lua file.
- Customizable Item Names: Change the name of the usable item in the config.lua file.
- Adjustable Progress Bar: Modify the progress bar duration to fit your needs.

### Inbuilt Limited Item Use System
- Usage Limits: Set the number of times an item can be used before it is broken.

### Logging
- Detailed Logging: Logs the player's character name, server ID, and FiveM name during a robbery.
- Comprehensive Item Details: Provides advanced details of the items being robbed, including weapon serial numbers, item amounts, and more.

# Credits

**A Huge thank you to the following people for their incredible contributions:**
- Thank you to [Kaiser-Fahim](https://github.com/KaiserFahim) for helping me find and fix bugs
- Thank you to [G H 0 S T](https://github.com/NoT-Gh0sT) for helping me find and fix bugs