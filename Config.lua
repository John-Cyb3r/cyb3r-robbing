Config = {}

Config.EnableItemRob = true -- Enable Item Robbing

Config.EnableCashRob = true -- Enable Cash Robbing
Config.CashRobMaxAmount = 10000 -- Maximum Amount Of Cash A Player Can rob and will disable the option to rob cash again
Config.CashRobCooldown = 10 -- In minutes, the cooldown which the robbing player must wait to rob cash again after they have already robbed him out the max amount

Config.EnableOxLibMenu = false

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