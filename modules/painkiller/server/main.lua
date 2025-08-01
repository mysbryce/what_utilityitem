for itemName, itemData in pairs(CONFIG_PAINKILLER) do
    ESX.RegisterUsableItem(itemName, function(source)
        if not CheckUsable(source, itemData?.usableJobs, itemData?.usableWhenHasAnyItem) then return end
        
        local removeItem = lib.callback.await('utilityitem:use:heal', source, itemName)
        if removeItem then
            if itemData.remove == nil or itemData.remove == true then
                local xPlayer = ESX.GetPlayerFromId(source)
                xPlayer.removeInventoryItem(itemName, 1)
            end
        end
    end)
end