# Cyb3r-Robbing
A custom script for roleplay servers that allows the specification of which items or cash which could be robbed from the player.

### Screenshot Previews - In a few screenshots I am using a modified version of qb-menu which doesn't show Item Images/Icons but With the Original one, you will be able to see them
## qb-menu 
![image](https://cdn.discordapp.com/attachments/1213222011170717706/1252421091125891163/Screenshot_430.png?ex=669668c8&is=66951748&hm=902e65197057880f8cd54ac3be1fcea2f237adea7aa1961f593eb7f6cf8ee0b2&)

![image](https://imgur.com/ZKSINyd.png)

![image](https://imgur.com/ZbHu9UO.png)

![image](https://imgur.com/jRw79mF.png)

## Ox_lib Context Menu

![image](https://imgur.com/Vo5CmxT.png)

![image](https://imgur.com/TPJoqKH.png)

![image](https://imgur.com/Q1mSLAs.png)

## Logs

![image](https://cdn.discordapp.com/attachments/1213222011170717706/1252424125792649276/image.png?ex=66966b9c&is=66951a1c&hm=c573656b3d060accc5d164f93de196528dab2469b600c373bdd14cff0c1fbc4e&)

![image](https://cdn.discordapp.com/attachments/1213222011170717706/1252424329568849982/image.png?ex=66966bcd&is=66951a4d&hm=0385a7dad357ec6c6f41d1495f8b6a2a64df301b01e571ee7ad70ba380947353&)

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
