RegisterNetEvent('utilityitem:aed:remove',  function(itemName)
    if not CONFIG_AED[itemName] then return end
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem(itemName, 1)
end)


for itemName, _ in pairs(CONFIG_AED) do
    ESX.RegisterUsableItem(itemName, function(source)
        TriggerClientEvent('utilityitem:use:aed', source, itemName)
    end)
end