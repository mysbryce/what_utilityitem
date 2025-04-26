AddEventHandler('esx:onPlayerDeath', function()
    LocalPlayer.state:set('iedead', true, true)
end)

AddEventHandler('esx:onPlayerSpawn', function()
    LocalPlayer.state:set('iedead', false, true)
end)