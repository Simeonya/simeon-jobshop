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

        if item.isWeapon then
            for _, w in pairs(xPlayer.getLoadout()) do
                if w.name == item.name then
                    TriggerClientEvent('esx:showNotification', source, string.format(Translation.alreadyHave, item.label))
                    return
                end
            end
        end

        local totalPrice = item.price * basketItem.count
        if not HasEnoughMoney(xPlayer, totalPrice) then
            TriggerClientEvent('esx:showNotification', source, Translation.notEnoughMoney)
            return
        end

        if not CanPlayerCarryItem(xPlayer, {
            name = item.name,
            amount = basketItem.count,
            isWeapon = item.isWeapon
        }) then
            TriggerClientEvent('esx:showNotification', source, Translation.notEnoughSpace)
            return
        end

        xPlayer.removeMoney(totalPrice)

        if item.isWeapon then
            xPlayer.addWeapon(item.name, item.ammo or 0)
        else
            xPlayer.addInventoryItem(item.name, basketItem.count)
        end
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

function GetItemRestrictionMessage(xPlayer, item)
    if #item.specifiedGradesOnly > 0 then
        return Translation.onlyWithGrad
    elseif item.minGrade then
        return string.format(Translation.onlySinceGrade, item.minGrade)
    end
    return nil
end

function CanPlayerCarryItem(xPlayer, item)
    if item.isWeapon then
        for _, w in pairs(xPlayer.getLoadout()) do
            if w.name == item.name then
                TriggerClientEvent('esx:showNotification', xPlayer.source,
                    string.format(Translation.alreadyHave, item.label))
                return false
            end
        end
        return xPlayer.getWeight() < xPlayer.getMaxWeight()
    else
        if xPlayer.canCarryItem then
            return xPlayer.canCarryItem(item.name, item.amount)
        end
        return true
    end
end

function HasEnoughMoney(xPlayer, price)
    return xPlayer.getMoney() >= price
end
