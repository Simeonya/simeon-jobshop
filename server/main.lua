ESX = exports['es_extended']:getSharedObject()

RegisterServerEvent('simeon:jobshop:server:buyBasket')
AddEventHandler('simeon:jobshop:server:buyBasket', function(data)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end

    local shop = GetShopForJob(xPlayer.getJob().name)
    if not shop then return end

    for _, basketItem in ipairs(data.items) do
        local item = GetItemFromShop(shop, basketItem.name)
        if not item then
            TriggerClientEvent('esx:showNotification', source, 'Ungültiger Artikel: ' .. (basketItem.name or 'Unbekannt'))
            return
        end

        if not CanPlayerBuyItem(xPlayer, item) then
            TriggerClientEvent('esx:showNotification', source, Translation.notAllowed)
            return
        end

        local totalPrice = item.price * basketItem.count
        if not HasEnoughMoney(xPlayer, totalPrice) then
            TriggerClientEvent('esx:showNotification', source, Translation.notEnoughMoney)
            return
        end

        if not CanPlayerCarryItem(xPlayer, {
            name = item.name,
            amount = basketItem.count
        }) then
            TriggerClientEvent('esx:showNotification', source, Translation.notEnoughSpace)
            return
        end

        xPlayer.removeMoney(totalPrice)
        xPlayer.addInventoryItem(item.name, basketItem.count)
    end

    TriggerClientEvent('esx:showNotification', source, "Einkauf abgeschlossen.")
end)

function GetShopForJob(jobName)
    return Config.Shops[jobName]
end

function GetItemFromShop(shop, itemName)
    for _, item in pairs(shop.items) do
        if item.name == itemName then
            return item
        end
    end
    return nil
end

function CanPlayerBuyItem(xPlayer, item)
    if #item.specifiedGradesOnly > 0 then
        for _, grade in pairs(item.specifiedGradesOnly) do
            if xPlayer.getJob().grade == grade then
                return true
            end
        end
        return false
    end

    return xPlayer.getJob().grade >= item.minGrade
end

function CanPlayerCarryItem(xPlayer, item)
    if xPlayer.canCarryItem then
        return xPlayer.canCarryItem(item.name, item.amount)
    end
    return true
end

function HasEnoughMoney(xPlayer, price)
    return xPlayer.getMoney() >= price
end
