-- Q2 - Fix or improve the implementation of the below method

-- function printSmallGuildNames(memberCount)
-- -- this method is supposed to print names of all guilds that have less than memberCount max members
--     local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
--     local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount))
--     local guildName = result.getString("name")
--     print(guildName)
-- end

function printGuildNamesOfSizeLessThan(memberCount)
    -- this method is supposed to print names of all guilds that have less than memberCount max members
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
    local results = db.storeQuery(string.format(selectGuildQuery, memberCount))
    
    -- Before there was no "result" variable declared (resultId -> results & result -> resultElement)
    -- resultId (now results) should recieve a series of results from the database Query
    -- We need to go through the series by each element to report all of the guild names of the condition  
    for resultElement in results do
        local guildName = resultElement.getString("name")
        print(guildName)
    end
end