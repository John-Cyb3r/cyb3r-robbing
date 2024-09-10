Config = {}

Config.EnableItemRob = true -- Enable Item Robbing

Config.EnableAlivePlayerRob = true -- Allows players to rob other players even if they are alive
Config.CheckPlayerHandCuffed = false -- Uses QBCore's Meta Data to check if the player being robbed is handcuffed
Config.CheckIsWeaponOnHand = true -- Checks if the player robbing has a weapon in hand
Config.UseAnyWeaponOnHand = false -- Player Can Use Any Weapon to rob
Config.WeaponsNotAllowed = { -- Enabled when Config.UseAnyWeaponOnHand set to true and excludes some weapons
    GetHashKey("WEAPON_KNIFE"),
    GetHashKey("WEAPON_BAT"),
    GetHashKey("WEAPON_HAMMER"),
    GetHashKey("WEAPON_CROWBAR"),
    GetHashKey("WEAPON_UNARMED"),
}
Config.WeaponsAllowed = { -- List of names of weapons that the person can use to rob players | Disabled when Config.UseAnyWeaponOnHand = true
    GetHashKey("WEAPON_PISTOL"),
}

Config.EnableRobbingCommand = true -- Allows players to rob a player using /rob and doesn't require the item
Config.RobbingCommand = "rob" -- Robbing Command Used By the player
Config.RobbingCommandPerms = "user" -- user = everyone | admin = server players with qbcore adminstators perms | god = server players qbcore with god perms

Config.EnableCashRob = true -- Enable Cash Robbing
Config.CashRobMaxAmount = 10000 -- Maximum Amount Of Cash A Player Can rob and will disable the option to rob cash again
Config.CashRobCooldown = 10 -- In minutes, the cooldown which the robbing player must wait to rob cash again after they have already robbed him out the max amount

Config.EnableOxLibMenu = true
Config.InventoryImages = "qb-inventory/html/images"

Config.RobbingKit = "robbingkit"
Config.SearchProgressTime = 1000 -- 10second

Config.Logs = true -- Use Inbuild logs
Config.WebhookUrl = "YOUR_DISCORD_WEBHOOK_URL_HERE" -- Your discord log channel Webhook

Config.RobbingKitUses = 5 -- Amount of uses a robbing kit will have

Config.StealableItemsMaxAmountCooldown = 10 -- In minutes, the cooldown which the robbing player must wait to rob that item again after they have already robbed him out the max amount
Config.StealableItemsMaxAmount = {  -- If player item name is from this table it will only allow them to rob the max amount and will disable the option to rob the item again
    ["bandage"] = 10,
    ["painkillers"] = 10,
}

Config.StealableItems = { -- List of names of items that can be stolen from others 
    "bandage",
    "weapon_pistol",
}

Config.DoNotStealCertainItems = true -- If set to true, it will disable "Config.StealableItems" and allow players to steal every item except for the ones listed below
Config.DoNotSteal = {
    "weapon_carbinerifle",
}