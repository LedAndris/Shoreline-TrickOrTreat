ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('TrickOrTreat:giveItems')
AddEventHandler('TrickOrTreat:giveItems', function(house)

    local homeChance = math.random(1, Config.Chance)
    local largeHouse = math.random(1, Config.LargeHouse)
    local mediumHouse = math.random(1, Config.MediumHouse)
    local smallHouse = math.random(1, Config.SmallHouse)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    print('dasd')

    if homeChance == 1 then 
        if house == 'trick_large' then
            xPlayer.addInventoryItem('candyCorn', largeHouse)
            TriggerClientEvent('esx:showNotification', source, 'You got '.. largeHouse ..' candy bar!')
        elseif house == 'trick_medium' then
            xPlayer.addInventoryItem('candyCorn', mediumHouse)
            TriggerClientEvent('esx:showNotification', source, 'You got '.. mediumHouse ..' candy bar!')
        elseif house == 'trick_small' then
            xPlayer.addInventoryItem('candyCorn', smallHouse)
            TriggerClientEvent('esx:showNotification', source, 'You got '.. smallHouse ..' candy bar!')
        end
    else
        TriggerClientEvent('esx:showNotification', source, 'No one is home.')
    end
end)

ESX.RegisterUsableItem('candyCorn', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('candyCorn', 1)
    TriggerClientEvent('TrickOrTreat:useCandy')
    Citizen.Wait(1000)
end)