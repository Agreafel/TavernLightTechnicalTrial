-- Q1 Fix or improve the implementation of the below methods
-- local function releaseStorage(player)
--     player:setStorageValue(1000, -1)
-- end

-- function onLogout(player)
--     if player:getStorageValue(1000) == 1 then
--     addEvent(releaseStorage, 1000, player)
--     end
--     return true
-- end

-- better to allow releasing specific storage index for a specific player
-- matching the use case of the added event below
-- which has the index specified for the event
local function releaseStorage(player, index)
    -- Nil better reports that the value is unhelpful
    -- any value besides nil(and false) resolves as true
    player:setStorageValue(index, nil)
end

function onLogout(player)
    -- Would likely want to go through all storage indexes unless 1000 is special
    -- would need storage size access to iterate through all storage indices
    
    -- This will report false if the storage value was already released
    -- any value besides nil (and false) is resolved as true
    if player:getStorageValue(1000) then
        -- matching the order of, player then index
        -- still needs timing for the event (1000ms)
        addEvent(releaseStorage, 1000, player, 1000)
    end
    return true
end
