AddEventHandler('esx:onPlayerDeath', function()
    LocalPlayer.state:set('isdead', true, true)
end)

AddEventHandler('esx:onPlayerSpawn', function()
    LocalPlayer.state:set('isdead', false, true)
end)