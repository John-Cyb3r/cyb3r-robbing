# Cyb3r-Robbing
A custom script for roleplay servers that allows the specification of which items or cash which could be robbed from the player.

## Screenshot Previews - I am using a modified version of qb-menu which doesn't show Item Images/Icons but With the Original one, you will be able to see them
![image](https://media.discordapp.net/attachments/1213222011170717706/1252421091125891163/Screenshot_430.png?ex=66722788&is=6670d608&hm=9b137ce95220e5717428bbcb63d1313824da4bf0aeff14e658e81b404845aba8&=&format=webp&quality=lossless&width=1193&height=671)
![image](https://media.discordapp.net/attachments/1213222011170717706/1252421092065284177/Screenshot_431.png?ex=66722789&is=6670d609&hm=76439cda76b50a64e43ccc58f3c6a899a2518462fc0d2de98c239ebce477f144&=&format=webp&quality=lossless&width=1193&height=671)
![image](https://cdn.discordapp.com/attachments/1213222011170717706/1252421092744892497/Screenshot_432.png?ex=66722789&is=6670d609&hm=fc81f8a2cb808f77b92c2aa583a725d6f907b30d9020bdf8e408174b8f0fabc8&)
![image](https://cdn.discordapp.com/attachments/1213222011170717706/1252421095139709010/Screenshot_433.png?ex=66722789&is=6670d609&hm=57123299f03180b7b4a2075c79252862534e72fe1acc708fd99e3374e4ffc285&)
![image](https://cdn.discordapp.com/attachments/1213222011170717706/1252424125792649276/image.png?ex=66722a5c&is=6670d8dc&hm=fe2a341afffd4582cadf3685727717769d5c0de389d1a4625724944c13ce1fec&)
![image](https://cdn.discordapp.com/attachments/1213222011170717706/1252424329568849982/image.png?ex=66722a8d&is=6670d90d&hm=8a023528bcdc3963264252ff34c89ab5b28914db3d2b3897106400f5600b1e5c&)

## Dependencies
- qb-menu - For The Context Menus
- qb-smallresources - For Logging robbed items and the cash (Optional - Only required for the logs)
- progressbar - For the progressbar while searching the person

# How to install

- Place the folder in your resources folder
- add the following code to your server.cfg file

```
ensure Cyb3r-robbing
```
### Installation

- Add the following line of code to your `logs.lua` in file inside qb-smallresources under the `Webhooks` adn replace it with your discord webhook url

```lua
-- Cyb3r-Robbing
['Cyb3r-robbing'] = 'YOUR_DISCORD_WEBHOOK_URL',

```

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

# Credits

**A Huge thank you to the following people for their incredible contributions:**
- Thank you to [Kaiser-Fahim](https://github.com/KaiserFahim) for helping me find and fix bugs
- Thank you to [G H 0 S T](https://github.com/NoT-Gh0sT) for helping me find and fix bugs