// Q4 - Assume all method calls work fine. Fix the memory leak issue in below method
// void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
// {
//     Player* player = g_game.getPlayerByName(recipient);
//     if (!player) {
//         player = new Player(nullptr);
//         if (!IOLoginData::loadPlayerByName(player, recipient)) {
//             return;
//         }
//     }

//     Item* item = Item::CreateItem(itemId);
//         if (!item) {
//             return;
//     }

//     g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

//     if (player->isOffline()) {
//         IOLoginData::savePlayer(player);
//     }
// }

void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
    Player* player = g_game.getPlayerByName(recipient);
    if (!player) {

        // Changing which spot in memory the variable player was pointing to
        // without removing the memory from the location it previosuly pointed to
        // loses access to the memory
        
        // player ---> |__FirstValue__|

        // ??? ---> |__FirstValue__| Lost reference, uncleanable
        // player ---> ~nullptr~
        
        //REMOVED: player = new Player(nullptr);
        
        // this is attempting to read a null player either way, 
        // no reason to change the pointer here
        if (!IOLoginData::loadPlayerByName(player, recipient)) {
            return;
        }
    }
    
    Item* item = Item::CreateItem(itemId);
        if (!item) {
            return;
    }

    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    if (player->isOffline()) {
        IOLoginData::savePlayer(player);
    }
}