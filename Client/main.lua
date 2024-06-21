local QBCore = exports['qb-core']:GetCoreObject()

local PlayerRobbedCashRecent = {}
local PlayerRobbedItemRecent = {}

RegisterNetEvent('Cyb3r-robitem:UpdateRobCash', function(data)
	PlayerRobbedCashRecent = data
end)

local function hasBeenRobbedRecently(playerId)
    local MinutesInMillis = Config.CashRobCooldown * 60 * 1000
    local currentTime = GetGameTimer()
    if PlayerRobbedCashRecent[playerId] then
        if (currentTime - PlayerRobbedCashRecent[playerId]) < MinutesInMillis then
            return true
		else
			PlayerRobbedCashRecent[playerId] = nil
		end
    end

    return false
end

RegisterNetEvent('Cyb3r-robitem:UpdateRobItems', function(data)
	PlayerRobbedItemRecent = data
end)

local function hasBeenRobbedItemRecently(playerId, itemname, slot)
    local MinutesInMillis = Config.StealableItemsMaxAmountCooldown * 60 * 1000
    local currentTime = GetGameTimer()
    if PlayerRobbedItemRecent[playerId] and PlayerRobbedItemRecent[playerId][itemname] and PlayerRobbedItemRecent[playerId][itemname][slot] then
		print(GetGameTimer())
		print(currentTime - PlayerRobbedItemRecent[playerId][itemname][slot].lastRobbedTime)
        if (currentTime - PlayerRobbedItemRecent[playerId][itemname][slot].lastRobbedTime) < MinutesInMillis then

            return true
        end
    end

    return false
end

local function isStealable(item)
	if not Config.DoNotStealCertainItems then
		if item then
    		for _, stealableItem in ipairs(Config.StealableItems) do
    		    if item == stealableItem then
    		        return true
    		    end
    		end
		end
    	return false
	else
		if item then
    		for _, stealableItem in ipairs(Config.DoNotSteal) do
    		    if item == stealableItem then
    		        return false
    		    end
    		end
		end
    	return true
	end
end

local function GetClosestPlayer()
    local players = QBCore.Functions.GetPlayers()
    local closestPlayer = -1
    local closestDistance = -1
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    for _, playerId in ipairs(players) do
        local targetPed = GetPlayerPed(playerId)
        if targetPed ~= playerPed and IsPedAPlayer(targetPed) then  -- Ensure the target is not the local player and is a valid player ped
            local targetCoords = GetEntityCoords(targetPed)
            local distance = #(playerCoords - targetCoords)

            if closestDistance == -1 or distance < closestDistance then
                closestPlayer = playerId
                closestDistance = distance
            end
        end
    end

    return closestPlayer, closestDistance
end

RegisterNetEvent('Cyb3r-robitem:openmenu', function()

	local ClosestPlayer, distance = GetClosestPlayer()
	--print(GetPlayerServerId(ClosestPlayer), distance)
	if ClosestPlayer and distance < 2 then
		QBCore.Functions.TriggerCallback('Cyb3r-robitem:isplayerdead', function(bool)
			if bool and bool ~= "brokenitem" then
				exports["rpemotes"]:EmoteCommandStart('medic')
				QBCore.Functions.Notify('You started searching the players body', 'success', 5000)
				QBCore.Functions.Notify(ClosestPlayer, 'You are being searched by another player', 'error', 5000)
				QBCore.Functions.Progressbar("random_task", "Searching Player\'s Body", tonumber(Config.SearchProgressTime), false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {}, {}, {}, function()
					exports["rpemotes"]:EmoteCancel()

					TriggerEvent('Cyb3r-robitem:mainMenu', {tPlayerId = GetPlayerServerId(ClosestPlayer)})

				end, function()
					exports["rpemotes"]:EmoteCancel()
					QBCore.Functions.Notify('You stopped searching the Player', 'error')
				end)
			elseif bool == "brokenitem" then
				QBCore.Functions.Notify('The RobbingKit is broken, Please get a new one' , 'error', 3000)
			else
				QBCore.Functions.Notify('Player is not fully dead yet', 'error')
			end
		end, GetPlayerServerId(ClosestPlayer))
	else
		QBCore.Functions.Notify('You are not close enough to the player', 'error')
	end
end)

RegisterNetEvent('Cyb3r-robitem:clientrobitem', function(data)
	data.time = GetGameTimer() 
	TriggerServerEvent('Cyb3r-robitem:RobItem', data)
end)

RegisterNetEvent('Cyb3r-robitem:clientrobcash', function(data)
	data.time = GetGameTimer() 
	TriggerServerEvent('Cyb3r-robitem:RobCash', data)
end)

RegisterNetEvent('Cyb3r-robitem:opensubmenu-items', function(data)
	if Config.EnableOxLibMenu then
		local menu = {	
			id = 'RobbingItemSubMenu',
			title = 'Rob Player Items',
			menu = 'RobbingMainMenu',
			options = {}
		}

		local playerid = GetPlayerServerId(PlayerId())

    	QBCore.Functions.TriggerCallback('Cyb3r-robitem:GetPlayerInventory', function(playerItems)
    	    if playerItems then
    	    	for _, item in pairs(playerItems) do
					local itemicon = "fa-lightbulb"
					if item.type == "weapon" then
						itemicon = "fa-gun"
					end
					local RobAmount = item.amount
					if Config.StealableItemsMaxAmount[item.name] then
						if item.amount > Config.StealableItemsMaxAmount[item.name]  then 
							RobAmount = Config.StealableItemsMaxAmount[item.name]
						end
					end
    	    	    if isStealable(item.name) then
						table.insert(menu.options, {
							title = item.label.." [Amount: " .. RobAmount.."]" ,
							description = "[SLOT: "..item.slot.."]",
							icon = itemicon,
							disabled = hasBeenRobbedItemRecently(data.targetPlayerId, item.name, item.slot),
							event = 'Cyb3r-robitem:clientrobitem',
							args = {
								stealingPlayerId = playerid,
								robbedPlayerId = data.targetPlayerId,
								itemName = item.name,
								itemAmount = RobAmount,
								itemSlot = item.slot,
							}
						})
    	    	    end
    	    	end
    	    else
    	        QBCore.Functions.Notify('Player not found or Inventory is empty', 'error')
			end
    	end, data.targetPlayerId)

		Wait(250)
		lib.registerContext(menu)
		lib.showContext('RobbingItemSubMenu')
	else
		local menu = {
			{
				header = "Go Back",
				icon = 'fas fa-backward',
				params = {
					event = 'Cyb3r-robitem:mainMenu',
					args = { tPlayerId = data.targetPlayerId }
				}
			}
		}
		local playerid = GetPlayerServerId(PlayerId())

    	QBCore.Functions.TriggerCallback('Cyb3r-robitem:GetPlayerInventory', function(playerItems)
    	    if playerItems then
    	    	for _, item in pairs(playerItems) do
    	    	    if isStealable(item.name) then
						local RobAmount = item.amount
						if Config.StealableItemsMaxAmount[item.name] then
							if item.amount > Config.StealableItemsMaxAmount[item.name]  then 
								RobAmount = Config.StealableItemsMaxAmount[item.name]
							end
						end
    	    	        table.insert(menu, {
    	    	            header = item.label,
    	    	            txt = "Item Amount: " .. RobAmount,
							disabled = hasBeenRobbedItemRecently(data.targetPlayerId, item.name, item.slot),
    	    	            icon = item.name,  -- Use a generic icon or map item name to specific icons
    	    	            params = {
    	    	                -- isServer = true,
    	    	                event = 'Cyb3r-robitem:clientrobitem',
    	    	                args = {
    	    	                    stealingPlayerId = playerid,
    	    	                    robbedPlayerId = data.targetPlayerId,
    	    	                    itemName = item.name,
									itemAmount = RobAmount,
									itemSlot = item.slot,
    	    	                }
    	    	            }
    	    	        })
    	    	    end
    	    	end
    	    else
    	        QBCore.Functions.Notify('Player not found or Inventory is empty', 'error')
			end
			exports['qb-menu']:openMenu(menu)
    	end, data.targetPlayerId)
	end
end)




RegisterNetEvent('Cyb3r-robitem:opensubmenu-cash', function(data)
	if Config.EnableOxLibMenu then
		local menu = {	
			id = 'RobbingCashSubMenu',
			title = 'Rob Player Cash',
			menu = 'RobbingMainMenu',
			options = {}
		}

		QBCore.Functions.TriggerCallback('Cyb3r-robitem:GetPlayerCash', function(cashAmount)
			if cashAmount then
				local bool = false
				if cashAmount <= 0 or hasBeenRobbedRecently(data.targetPlayerId) then bool = true end
				if cashAmount > Config.CashRobMaxAmount then 
					cashAmount = Config.CashRobMaxAmount 
				end
				table.insert(menu.options, {
					title = "Player Cash Amount: "..cashAmount,
					description = "Rob Cash From Player!",
					disabled = bool,
					icon = 'fa-money-bill-wave',
					event = "Cyb3r-robitem:clientrobcash",
					args = {
						sourcePlayerId = GetPlayerServerId(PlayerId()),
						targetPlayerId = data.targetPlayerId,
						amount = cashAmount
					}
				})
			else
				QBCore.Functions.Notify('Player Cash not found', 'error')
			end
		end, data.targetPlayerId)
		Wait(100)
		lib.registerContext(menu)
		lib.showContext('RobbingCashSubMenu')
	else
		local menu = {
			{
				header = "Go Back",
				icon = 'fas fa-backward',
				params = {
					event = 'Cyb3r-robitem:mainMenu',
					args = {tPlayerId = data.targetPlayerId	}
				}
			},
		}
		QBCore.Functions.TriggerCallback('Cyb3r-robitem:GetPlayerCash', function(cashAmount)
			if cashAmount then
				local bool = false
				if cashAmount <= 0 or hasBeenRobbedRecently(data.targetPlayerId) then bool = true end
				if cashAmount > Config.CashRobMaxAmount then 
					cashAmount = Config.CashRobMaxAmount 
				end
    			table.insert(menu, {
    			    header = "Player Cash Amount: "..cashAmount,
    			    txt = "Rob Cash From Player!",
					disabled = bool,
					icon = 'fas fa-money-bill-wave',
    			    params = {
						-- isServer = true,
    			        event = "Cyb3r-robitem:clientrobcash",
    			        args = {
    			            sourcePlayerId = GetPlayerServerId(PlayerId()),
							targetPlayerId = data.targetPlayerId,
							amount = cashAmount
    			        }
    			    }
    			})
			else
				QBCore.Functions.Notify('Player Cash not found', 'error')
			end
			exports['qb-menu']:openMenu(menu)
		end, data.targetPlayerId)
	end
end)

RegisterNetEvent('Cyb3r-robitem:mainMenu', function(data)
	if Config.EnableOxLibMenu then
		local menu = {	
			id = 'RobbingMainMenu',
			title = 'Robbing Options',
			options = {}
		}
		if Config.EnableItemRob then
			table.insert(menu.options, {
				title = 'Search For Items',
				description = 'Search For Items In The Body!',
				icon = 'fa-magnifying-glass',
				arrow = true,
				event = 'Cyb3r-robitem:opensubmenu-items',
				args = {
					targetPlayerId = data.tPlayerId
				}

			})
		end
		if Config.EnableCashRob then  
			table.insert(menu.options, {
				title = 'Search For Cash',
				description = 'Search For Cash In The Body!',
				icon = 'fas fa-money-bills',
				arrow = true,
				-- isServer = false, -- optional, specify event type
				event = 'Cyb3r-robitem:opensubmenu-cash',
				args = {
					targetPlayerId = data.tPlayerId
				}
			})
		end
		lib.registerContext(menu)
		lib.showContext('RobbingMainMenu')
	else
		local menu = {
			{
				header = 'Robbing Options',
				txt = 'Target Player ID: '..data.tPlayerId,
				icon = 'fas fa-person-rifle',
				isMenuHeader = true, -- Set to true to make a nonclickable title
			},
		}
		if Config.EnableItemRob then
			table.insert(menu, {
				header = 'Search For Items',
				txt = 'Search For Items In The Body!',
				icon = 'fas fa-magnifying-glass',
				params = {
					event = 'Cyb3r-robitem:opensubmenu-items',
					args = {
						targetPlayerId = data.tPlayerId
					}
				}
			})
		end
		if Config.EnableCashRob then  
			table.insert(menu, {
				header = 'Search For Cash',
				txt = 'Search For Cash In The Body!',
				icon = 'fas fa-money-bills',
				-- disabled = false, -- optional, non-clickable and grey scale
				-- hidden = true, -- optional, hides the button completely
				params = {
					-- isServer = false, -- optional, specify event type
					event = 'Cyb3r-robitem:opensubmenu-cash',
					args = {
						targetPlayerId = data.tPlayerId
					}
				}
			})
		end
		exports['qb-menu']:openMenu(menu)
	end
end)
