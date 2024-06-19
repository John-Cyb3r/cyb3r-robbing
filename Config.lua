Config = {}

Config.EnableItemRob = true -- Enable Item Robbing
Config.EnableCashRob = true -- Enable Cash Robbing

Config.RobbingKit = "robbingkit"
Config.SearchProgressTime = 10000 -- 10second

Config.QBlogging = true -- Uses default qb logs

Config.RobbingKitUses = 5 -- Amount of uses a robbing kit will have

Config.StealableItems = { -- List of names of items that can be stolen from others 
    "bandage",
    "weapon_carbinerifle",
}

Config.DoNotStealCertainItems = true -- If set to true, it will disable "Config.StealableItems" and allow players to steal every item except for the ones listed below
Config.DoNotSteal = {
    "weapon_pistol",
}