# Cyb3r-Robbing
A custom script for roleplay servers that allows the specification of which items or cash which could be robbed from the player.

### Screenshot Previews - In a few screenshots I am using a modified version of qb-menu which doesn't show Item Images/Icons but With the Original one, you will be able to see them
## qb-menu 
![image](https://media.discordapp.net/attachments/1213222011170717706/1252421091125891163/Screenshot_430.png?ex=66722788&is=6670d608&hm=9b137ce95220e5717428bbcb63d1313824da4bf0aeff14e658e81b404845aba8&=&format=webp&quality=lossless&width=1193&height=671)

![image](https://cdn.discordapp.com/attachments/1213222011170717706/1254021551381155881/image.png?ex=6677fa14&is=6676a894&hm=b96d3216dcd86410eff572d0c40bc846bbcf9939227ee9098dda6f21b347e65a&)

![image](https://cdn.discordapp.com/attachments/1213222011170717706/1254021978981924978/image.png?ex=6677fa7a&is=6676a8fa&hm=677914ae0e5661645f09993cbc5dedaed174654e24861a7895db9addcab02eb6&)

![image](https://cdn.discordapp.com/attachments/1213222011170717706/1254021690078396416/image.png?ex=6677fa35&is=6676a8b5&hm=3638661677079cdb5a6ea80b2b4a93927ba027278be29661e0ad9190f26273a4&)

## Ox_lib Context Menu

![image](https://cdn.discordapp.com/attachments/1213222011170717706/1254020203088576534/image.png?ex=6677f8d2&is=6676a752&hm=6542fa4911fee4cf0d36a4e111425eee7aff4b2454bcad729dedda868ddd7d19&)

![image](https://cdn.discordapp.com/attachments/1213222011170717706/1254020366268104804/image.png?ex=6677f8f9&is=6676a779&hm=d6933bf67e03f9b67a8399b2bd3464abd90455ca86195b72773cc58d010834e2&)

![image](https://cdn.discordapp.com/attachments/1213222011170717706/1254019216252604536/image.png?ex=6677f7e7&is=6676a667&hm=752cbe27657a7200c1af72b8cd281ba27a27439f382ada98890f484c33869585&)

## Logs

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