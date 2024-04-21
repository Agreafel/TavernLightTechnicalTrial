-- function do_sth_with_PlayerParty(playerId, membername)
--     player = Player(playerId)
--     local party = player:getParty()
    
--     for k,v in pairs(party:getMembers()) do
--         if v == Player(membername) then
--          party:removeMember(Player(membername))
--         end
--     end
-- end

function removeMemberFromPlayerParty(playerId, membername)
    -- We do not need to save the current player in memory 
    -- as it is only accessed to get the party
    local party = Player(playerId):getParty()
    
    -- Don't Repeat Yourself
    -- Made a variable to reduce the calls for the same target member
    local targetMember = Player(membername)
    
    -- We did not need the table keys here as we will not be accessing them (indices)
    -- break out of loop once the removal is done, saves some time (still O(n) as n is the number of members)
    for _, member in ipairs(party:getMembers()) do
        if member == targetMember then
            party:removeMember(targetMember)
            break
        end
    end
end