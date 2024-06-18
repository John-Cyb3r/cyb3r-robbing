local QBCore = exports['qb-core']:GetCoreObject()

local function GetPlayerIdFromPed(targetPed)
    for _, player in ipairs(GetActivePlayers()) do
        local playerPed = GetPlayerPed(player)
        if playerPed == targetPed then
            return GetPlayerServerId(player)
        end
    end
    return nil
end

local function isStealable(item)
	if item then
    	for _, stealableItem in ipairs(Config.StealableItems) do
    	    if item == stealableItem then
    	        return true
    	    end
    	end
	end
    return false
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

RegisterNetEvent('cyber-robitem:openmenu', function()
	local ClosestPlayer, distance = GetClosestPlayer()
	--print(GetPlayerServerId(ClosestPlayer), distance)
	if ClosestPlayer and distance < 2 then
		QBCore.Functions.TriggerCallback('cyber-robitem:isplayerdead', function(bool)
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

					TriggerEvent('cyber-robitem:mainMenu', {tPlayerId = GetPlayerServerId(ClosestPlayer)})

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

-- RegisterNetEvent('cyber-robitem:opensubmenu-items', function(data)

-- 	--print(data.targetPlayerId)
-- 	QBCore.Functions.TriggerCallback('cyber-robitem:GetPlayerInventory', function(playerItems)
-- 		if playerItems then

--         	local menu = {
--         	    {
--         	        header = "Go Back",
--         	        icon = 'fas fa-backward',
--         	        params = {
--         	            event = 'cyber-robitem:mainMenu',
--         	            args = {tPlayerId = data.targetPlayerId}
--         	        }
--         	    }
--         	}
		
--         	-- Loop through the player's items and add them to the menu
--         	for _, item in ipairs(playerItems) do
--         	    if isStealable(item.name) then
--         	        table.insert(menu, {
--         	            header = item.label,
--         	            txt = "Item Amount: " .. item.amount,
--         	            icon = item.name,  -- Use a generic icon or map item name to specific icons
--         	            params = {
-- 							isServer = true,
--         	                event = 'cyber-robitem:RobItem',
--         	                args = { 
-- 								stealingPlayerId = GetPlayerServerId(PlayerId()),
-- 								robbedPlayerId = data.targetPlayerId,
--         	                    itemName = item.name,
--         	                    itemAmount = item.amount
--         	                }
--         	            }
--         	        })
--         	    end
--         	end

--         	exports['qb-menu']:openMenu(menu)
-- 		else

-- 			exports['qb-menu']:openMenu(menu)

-- 			QBCore.Functions.Notify('Player not found or Inventory is empty', 'error')
-- 		end
-- 	end, data.targetPlayerId)

-- end)

RegisterNetEvent('cyber-robitem:opensubmenu-items', function(data)
	local menu = {
		{
			header = "Go Back",
			icon = 'fas fa-backward',
			params = {
				event = 'cyber-robitem:mainMenu',
				args = { tPlayerId = data.targetPlayerId }
			}
		}
	}
	local playerid = GetPlayerServerId(PlayerId())
	
    QBCore.Functions.TriggerCallback('cyber-robitem:GetPlayerInventory', function(playerItems)
		local time
		while not playerItems do
			time = time + 1
			if time > 2000 then
				break
			end
			Wait(1)
		end

        if playerItems then
        	for _, item in pairs(playerItems) do
        	    if isStealable(item.name) then
        	        table.insert(menu, {
        	            header = item.label,
        	            txt = "Item Amount: " .. item.amount,
        	            icon = item.name,  -- Use a generic icon or map item name to specific icons
        	            params = {
        	                isServer = true,
        	                event = 'cyber-robitem:RobItem',
        	                args = {
        	                    stealingPlayerId = playerid,
        	                    robbedPlayerId = data.targetPlayerId,
        	                    itemName = item.name,
        	                    itemAmount = item.amount
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
end)




RegisterNetEvent('cyber-robitem:opensubmenu-cash', function(data)
	--print(data.targetPlayerId)
	local menu = {
		{
			header = "Go Back",
			icon = 'fas fa-backward',
			params = {
				event = 'cyber-robitem:mainMenu',
				args = {tPlayerId = data.targetPlayerId	}
			}
		},
	}
	QBCore.Functions.TriggerCallback('cyber-robitem:GetPlayerCash', function(cashAmount)
		if cashAmount then
			local bool = false
			if cashAmount <= 0 then bool = true end
    		table.insert(menu, {
    		    header = "Player Cash Amount: "..cashAmount,
    		    txt = "Rob Cash From Player!",
				disabled = bool,
				icon = 'fas fa-money-bill-wave',
    		    params = {
					isServer = true,
    		        event = "cyber-robitem:RobCash",
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
end)

RegisterNetEvent('cyber-robitem:mainMenu', function(data)
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
				event = 'cyber-robitem:opensubmenu-items',
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
				event = 'cyber-robitem:opensubmenu-cash',
				args = {
					targetPlayerId = data.tPlayerId
				}
			}
		})
	end
	exports['qb-menu']:openMenu(menu)
end)

-- RegisterCommand('qbmenutest', function(source)
-- 	print("cmd: "..source)
-- 	TriggerEvent('cyber-robitem:mainMenu', 1)
-- end)

