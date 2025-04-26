lib.callback.register("utilityitem:use:heal", function (itemName)
    local playerPed = PlayerPedId()

    if IsPedInAnyVehicle(playerPed, false) then return  false end

    ClearPedSecondaryTask(ped)

    lib.requestAnimDict('anim@heists@narcotics@funding@gang_idle');
    TaskPlayAnim(playerPed, 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01', 8.0, -8.0, 3000, 0, 0,  false, false, false)

    local objectName = 'prop_ld_health_pack'
    lib.requestModel(objectName);

    local coords = GetEntityCoords(playerPed)
    local prop = CreateObject(GetHashKey(objectName), coords.x, coords.y, coords.z, true, true, true)
    local boneInde = GetPedBoneIndex(playerPed, 36029)
    AttachEntityToEntity(prop, playerPed, boneInde, 0.0, 0.0, 0.0, 0.0, 90.0, 0.0, true, true, false, true, 1, true)

    CreateThread(function()

        local itemConfig = CONFIG_PAINKILLER[itemName]
        local duration   = itemConfig?.duration or 3000
        local addHealth     = itemConfig?.health or 20

        local startTime = GetGameTimer()

        while (GetGameTimer() - startTime) <= duration do  Wait(0) end

        DeleteEntity(prop)

        local health = GetEntityHealth(playerPed)

        SetEntityHealth(playerPed, health + addHealth)
        ClearPedSecondaryTask(playerPed)
        RemoveAnimDict('anim@heists@narcotics@funding@gang_idle')
    end)

    return true
end)