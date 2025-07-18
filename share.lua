if IsDuplicityVersion() then
    --- @param playerId integer
    --- @param usableJobs What.Configuration.UsableJob?
    --- @param usableItems What.Configuration.UsableWhenHasAnyItem?
    --- @return boolean
    function CheckUsable(playerId, usableJobs, usableItems)
        if not usableJobs then return true end
        if not usableItems then return true end

        if DoesPlayerExist(playerId --[[ @as string ]]) then
            local xPlayer = ESX.GetPlayerFromId(playerId)
            if not xPlayer then return false end

            local allowed = false

            for neededItem, neededCount in pairs(usableItems) do
                local targetItem = xPlayer.getInventoryItem(neededItem)
                if targetItem and targetItem?.count >= neededCount then
                    allowed = true
                    break
                end
            end

            if allowed then return true end

            if usableJobs?.all then
                allowed =  true
            elseif not usableJobs?.all and usableJobs?.list then
                local playerJob = xPlayer.job.name
                if usableJobs?.list[playerJob] and (usableJobs?.list[playerJob]?[xPlayer.job.grade] or usableJobs?.list[playerJob]?.all) then
                    allowed =  true
                end
            end

            return allowed
        end

        return false
    end
else
    --- @param text string
    --- @param duration integer
    --- @param type What.Notify.TypeInt
    function Notify(text, duration, type)
        --- @type What.Notify.TypeText
        local sendingType = 'info'
        if type == 1 then sendingType = 'success'
        elseif type == 2 then sendingType = 'error'
        elseif type == 3 then sendingType = 'info' end

        --- Send payload to your notification resource
    end
end

--- @param playerId integer
--- @return boolean
function CheckPlayerDead(playerId)
    local isDead = Player(playerId).state.isDead or false

    return isDead
end