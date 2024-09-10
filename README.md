# Cyb3r-Robbing
A custom script for roleplay servers that allows the specification of which items or cash which could be robbed from the player.

### Screenshot Previews - In a few screenshots I am using a modified version of qb-menu which doesn't show Item Images/Icons but With the Original one, you will be able to see them
## qb-menu 

![image](https://imgur.com/ZKSINyd.png)

![image](https://imgur.com/ZbHu9UO.png)

![image](https://imgur.com/jRw79mF.png)

## Ox_lib Context Menu

![image](https://imgur.com/Vo5CmxT.png)

![image](https://imgur.com/TPJoqKH.png)

![image](https://imgur.com/Q1mSLAs.png)

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

### Update v1.1.0
- Added support for ox_lib context menu, incase you don't want to use qb menu
- Added Cash Rob Max Amount for players
- Added Cash Rob Cooldown, will disable option to rob cash after Max Amount is robbed (Configurable)
- Changed from qb-logs to inbuilt log system, just configure your webhookurl
- Added Max Stealable Items Limit, to limit players from robbing certain items 
- Added Cooldown For Max Stealable Items Limit, will disable option to rob that specific item after Max Amount is robbed (Configurable)
- Some Additional Bug Fixes

### Update v1.2.0
- Added support for robbing players who are alive
- Checks If the player being robbed  is handcuffed (Configurable)
- Checks If player had a specific gun (Configurable)
- Added customizable command for robbing players (doesn't require the item)
- Works With the New Version of qbcore (Including new qb-inventory)
- Some Additional Bug Fixes

# Credits

**A Huge thank you to the following people for their incredible contributions:**
- Thanks to [Kaiser-Fahim](https://github.com/KaiserFahim) for helping me find and fix bugs
- Thanks to [G H 0 S T](https://github.com/NoT-Gh0sT) for helping me find and fix bugs
