
if IsDuplicityVersion() then

else
    ---Notify Player 
    ---@param text text
    ---@param duration integer in millisecond
    ---@param type integer 1 = success 2 = error 3 = info
    function Notify(text, duration, type);

    end
end

function CheckPlayerDead(playerid)
    local isDead = Player(playerid).state.isdead or false

    return isDead
end