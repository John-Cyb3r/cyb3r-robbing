local QBCore = exports['qb-core']:GetCoreObject()

local PlayerRobbedItemRecent = {}
local PlayerRobbedCashRecent = {}

local function sendToDiscord(title, message) 

    local embeds = {
        {
            ["title"] = title,
            ["type"] = "rich",
            ["description"] = message,
            ["color"] = 16711680,  -- Red color
        }
    }
    if Config.WebhookUrl ~= "YOUR_DISCORD_WEBHOOK_URL_HERE" then
        PerformHttpRequest(Config.WebhookUrl, function(statusCode, response, headers)
            if statusCode ~= 204 then
                print("Failed to send log to Discord. Status code: " .. statusCode)
                print("Response:", response)
            end
        end, 'POST', json.encode({embeds = embeds}), {['Content-Type'] = 'application/json'})
    else
        print("Config.WebhookUrl Has Not Been Configured")
    end
end

QBCore.Functions.CreateUseableItem(Config.RobbingKit, function(source, item)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if not Player.Functions.GetItemByName(item.name) then 
        return 
    end

    TriggerClientEvent("Cyb3r-robitem:openmenu", src)
end)

QBCore.Functions.CreateCallback('Cyb3r-robitem:isplayerdead', function(source, cb, PlayerId)
    local Player = QBCore.Functions.GetPlayer(tonumber(PlayerId)) 
    local StealingPlayer = QBCore.Functions.GetPlayer(source)
    if Player and StealingPlayer then
        local bool = Player.PlayerData.metadata['isdead']
        if bool then
            local Item = StealingPlayer.Functions.GetItemByName(Config.RobbingKit)
            local ItemSlot = StealingPlayer.PlayerData.items[Item.slot]

            if ItemSlot.info.quality > 0 then
                ItemSlot.info.quality = ItemSlot.info.quality - (100 / tonumber(Config.RobbingKitUses)) 
                StealingPlayer.Functions.SetInventory(StealingPlayer.PlayerData.items, true)
                if Config.Logs then
                    local StealingPlayerName =  StealingPlayer.PlayerData.charinfo.firstname .. " " .. StealingPlayer.PlayerData.charinfo.lastname
                    local RobbedPlayerName =  Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
                    sendToDiscord("[Cyber-Robbing]",'**ID:** ``'..source..'`` **|** ``'..StealingPlayerName..' ('..GetPlayerName(source)..')`` **Is Robbing The Player ID:** ``'..PlayerId..'`` **|** ``'..RobbedPlayerName..' ('..GetPlayerName(PlayerId)..')``')
                end
                cb(bool)
            else
                bool = "brokenitem"
                cb(bool)
            end
        else
            cb(bool)
        end
    else
        cb(nil)
    end
end)

QBCore.Functions.CreateCallback('Cyb3r-robitem:GetPlayerInventory', function(source, cb, stealingPlayerId)

    local stealingPlayer = QBCore.Functions.GetPlayer(tonumber(stealingPlayerId))
    if stealingPlayer then
        local targetInventory = stealingPlayer.PlayerData.items
        cb(targetInventory)
    else
        cb(nil)
    end
    
end)

QBCore.Functions.CreateCallback('Cyb3r-robitem:GetPlayerCash', function(source, cb, targetPlayerId)
    --local sourcePlayer = QBCore.Functions.GetPlayer(source)
    local targetPlayer = QBCore.Functions.GetPlayer(targetPlayerId)
    if targetPlayer then
        local cashAmount = targetPlayer.PlayerData.money['cash']
        cb(cashAmount)
    else
        cb(nil)  -- You can send any signal to indicate failure, like nil
    end
end)

RegisterServerEvent('Cyb3r-robitem:RobItem', function(data)
    local robbedPlayerId, stealingPlayerId, itemName, itemAmount, itemSlot, currentTime = data.robbedPlayerId, data.stealingPlayerId, data.itemName, data.itemAmount, data.itemSlot, data.time
    local robbedPlayer = QBCore.Functions.GetPlayer(robbedPlayerId)
    local stealingPlayer = QBCore.Functions.GetPlayer(stealingPlayerId)

    -- local disable = false
    -- if hasBeenRobbedItemRecently(robbedPlayerId, itemName, itemSlot) then
    --     disable = true
    -- end
    if Config.StealableItemsMaxAmount[itemName] then

        if itemAmount >= Config.StealableItemsMaxAmount[itemName] then 
            if not PlayerRobbedItemRecent[robbedPlayerId] then
                PlayerRobbedItemRecent[robbedPlayerId] = {}
            end
            if not PlayerRobbedItemRecent[robbedPlayerId][itemName] then
                PlayerRobbedItemRecent[robbedPlayerId][itemName] = {}
            end
            PlayerRobbedItemRecent[robbedPlayerId][itemName][itemSlot] = { lastRobbedTime = currentTime }
            TriggerClientEvent('Cyb3r-robitem:UpdateRobItems', -1, PlayerRobbedItemRecent)
        end
    end

    if robbedPlayer and stealingPlayer then
        local robbedItem = robbedPlayer.Functions.GetItemByName(itemName)

        if robbedItem and robbedItem.amount >= itemAmount then
            -- Remove item from source player
            local removed = robbedPlayer.Functions.RemoveItem(itemName, itemAmount)
            if removed then
            TriggerClientEvent('inventory:client:ItemBox', robbedPlayerId, QBCore.Shared.Items[itemName], 'remove')
                -- Add item to target player
                local added = stealingPlayer.Functions.AddItem(itemName, itemAmount)
                if added then
                    TriggerClientEvent('inventory:client:ItemBox', stealingPlayerId, QBCore.Shared.Items[itemName], 'add')
                    TriggerClientEvent('QBCore:Notify', robbedPlayerId, itemAmount .. 'x ' .. robbedItem.label .. ' Has Been Robbed From You By ID: ' .. stealingPlayerId, 'success')
                    TriggerClientEvent('QBCore:Notify', stealingPlayerId, 'You have robbed ' .. itemAmount .. 'x ' .. robbedItem.label .. ' From ID: ' .. robbedPlayerId, 'success')
                    
                    -- Trigger the client event to update the menu for the stealing player
                    TriggerClientEvent('Cyb3r-robitem:opensubmenu-items', stealingPlayerId, { targetPlayerId = robbedPlayerId })

                    if Config.Logs then 
                        local StealingPlayerName =  stealingPlayer.PlayerData.charinfo.firstname .. " " .. stealingPlayer.PlayerData.charinfo.lastname
                        local RobbedPlayerName =  robbedPlayer.PlayerData.charinfo.firstname .. " " .. robbedPlayer.PlayerData.charinfo.lastname
                        sendToDiscord('**ID:** ``'..stealingPlayerId..'`` **|** ``'..StealingPlayerName..' ('..GetPlayerName(stealingPlayerId)..')`` **Robbed An Item From The Player ID:** ``'..robbedPlayerId..'`` **|** ``'..RobbedPlayerName..' ('..GetPlayerName(robbedPlayerId)..')``', '```json\n' .. json.encode(robbedItem, { indent = true })..'```')
                    end
                else
                    -- If adding the item to the target player failed, give it back to the source player
                    robbedPlayer.Functions.AddItem(itemName, itemAmount)
                    TriggerClientEvent('QBCore:Notify', robbedPlayerId, 'Robber\'s Inventory Is full', 'error')
                    TriggerClientEvent('QBCore:Notify', stealingPlayerId, 'Your Inventory Is full', 'error')
                end
            else
                TriggerClientEvent('QBCore:Notify', stealingPlayerId, 'Failed to remove/rob item', 'error')
            end
        else
            TriggerClientEvent('QBCore:Notify', stealingPlayerId, 'Player does not have the specified item', 'error')
        end
    else
        if not robbedPlayer then
            TriggerClientEvent('QBCore:Notify', stealingPlayerId, 'Robbed Player not found', 'error')
        end
        if not stealingPlayer then
            TriggerClientEvent('QBCore:Notify', stealingPlayerId, 'Stealing Player not found', 'error')
        end
    end
end)

RegisterServerEvent('Cyb3r-robitem:RobCash', function(data)
    local sourcePlayerId, targetPlayerId, amount, currentTime = tonumber(data.sourcePlayerId), tonumber(data.targetPlayerId), tonumber(data.amount), data.time
    --print(sourcePlayerId, targetPlayerId, amount)
    local sourcePlayer = QBCore.Functions.GetPlayer(sourcePlayerId)
    local targetPlayer = QBCore.Functions.GetPlayer(targetPlayerId)

    if sourcePlayer and targetPlayer then
        local targetPlayerCash = targetPlayer.PlayerData.money['cash']

        if targetPlayerCash >= amount then
            if amount >= Config.CashRobMaxAmount then 
                PlayerRobbedCashRecent[targetPlayerId] = GetGameTimer() 
                TriggerClientEvent('Cyb3r-robitem:UpdateRobCash', -1, PlayerRobbedCashRecent)
            end
            -- Remove cash from target player
            local removed = targetPlayer.Functions.RemoveMoney('cash', amount)
            if removed then
                -- Add cash to source player
                sourcePlayer.Functions.AddMoney('cash', amount)
                TriggerClientEvent('QBCore:Notify', sourcePlayerId, 'You have robbed $' .. amount .. ' from Player ID: ' .. targetPlayerId, 'success')
                TriggerClientEvent('QBCore:Notify', targetPlayerId, 'You have been robbed of $' .. amount .. ' by Player ID: ' .. sourcePlayerId, 'error')
                TriggerClientEvent('Cyb3r-robitem:opensubmenu-cash' ,sourcePlayerId, {targetPlayerId = targetPlayerId})

                if Config.Logs then
                    local StealingPlayerName =  sourcePlayer.PlayerData.charinfo.firstname .. " " .. sourcePlayer.PlayerData.charinfo.lastname
                    local RobbedPlayerName =  targetPlayer.PlayerData.charinfo.firstname .. " " .. targetPlayer.PlayerData.charinfo.lastname
                    sendToDiscord("[Cyber-Robbing]",'**ID:** ``'..sourcePlayerId..'`` **|** ``'..StealingPlayerName..' ('..GetPlayerName(sourcePlayerId)..')`` **Robbed Cash From The Player ID:** ``'..targetPlayerId..'`` **|** ``'..RobbedPlayerName..' ('..GetPlayerName(targetPlayerId)..')``', 'red', '**Cash Amount:** ``'..amount..'``')
                end
            else
                TriggerClientEvent('QBCore:Notify', sourcePlayerId, 'Failed to rob cash', 'error')
            end
        else
            TriggerClientEvent('QBCore:Notify', sourcePlayerId, 'The target player does not have enough cash', 'error')
        end
    else
        if not sourcePlayer then
            TriggerClientEvent('QBCore:Notify', sourcePlayerId, 'Source player not found', 'error')
        end
        if not targetPlayer then
            TriggerClientEvent('QBCore:Notify', sourcePlayerId, 'Target player not found', 'error')
        end
    end
end)

