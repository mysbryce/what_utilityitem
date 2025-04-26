local onRevive = false
local function UseReviveItem(itemName)
    if onRevive then return end
    if not CONFIG_AED[itemName] then return end

    local ped = lib.cache('ped');
    local ped_coords = GetEntityCoords(ped);

    local target_player, target_ped, _ = lib.getClosestPlayer(ped_coords, 2.0, false);

    if not target_player then return false end

    if IsPedInAnyVehicle(ped, false) then
        return Notify('ไม่สามารถชุบบนยานพาหนะได้', 3000, 2)
    end

    local drag_source = GetEntityAttachedTo(target_ped)
    if drag_source ~= 0 then
        if IsPedInAnyVehicle(drag_source, false) then return end
    end

    local target_serverid = GetPlayerServerId(target_player);
    local target_isdead = CheckPlayerDead(target_serverid)

    if not target_isdead then
        return Notify("ผู้เล่นยังมีชีวิตอยู่", 5000, 2)
    end


    onRevive = true

    Notify("กำลังชุบผู้เล่น", 5000, 1)

    local anim_lib, anim_name = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'
    lib.requestAnimDict(anim_lib)
    TaskPlayAnim(ped, anim_lib, anim_name, 8.0, -8.0, -1, 0, 0, false, false, false)

    local lastPlayAnim = GetGameTimer();


    local itemConfig = CONFIG_AED[itemName]

    local duration = itemConfig?.duration or 10000
    local health   = itemConfig?.health or 150


    TriggerEvent('mythic_progbar:client:ProgressWithStartAndTick', {
        name = "use_reviveitem",
        duration = duration,
        label = 'Revive Player...',
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement    = false,
            disableCarMovement = false,
            disableMouse       = false,
            disableCombat      = false
        },
    }, function ()
        lastPlayAnim = GetGameTimer();
        TaskPlayAnim(ped, anim_lib, anim_name, 8.0, -8.0, -1, 0, 0, false, false, false)
    end,
    function ()
        if IsControlJustPressed(0, 73) or IsDisabledControlJustPressed(0, 73) then
            TriggerEvent('mythic_progbar:client:cancel');
        end
        if (GetGameTimer() - lastPlayAnim) > 900 then
            lastPlayAnim = GetGameTimer();
            TaskPlayAnim(ped, anim_lib, anim_name, 8.0, -8.0, -1, 0, 0, false, false, false)
        end
    end,
    function (cancelled)
        onRevive = false;

        if not IsPedRunningRagdollTask(ped) then
            ClearPedTasks(ped)
        end

        if not cancelled then

            if not CheckPlayerDead(target_serverid) then
                return Notify("ผู้เล่นยังมีชีวิตอยู่", 5000, 2)
            end

            TriggerServerEvent('utilityitem:revive:player', target_serverid, health)

            if itemConfig.remove == nil or itemConfig.remove == true then
                TriggerServerEvent('utilityitem:aed:remove', itemName)
            end
        end
    end)
end

RegisterNetEvent("utilityitem:use:aed",  UseReviveItem)