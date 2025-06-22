ESX = exports['es_extended']:getSharedObject()

local playerJob = nil

RegisterNetEvent('esx:setJob', function(job)
    playerJob = job
end)

Citizen.CreateThread(function()
    while ESX.GetPlayerData().job == nil do
        Wait(100)
    end
    playerJob = ESX.GetPlayerData().job
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)

        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for jobName, shop in pairs(Config.Shops) do
            if playerJob and playerJob.name == jobName then
                for _, location in pairs(shop.locations) do
                    local dist = #(playerCoords - location)

                    if dist < Config.Marker.drawDistance then
                        DrawShopMarker(location)

                        if dist < 1.5 then
                            ESX.ShowHelpNotification(Translation.openShop)

                            if IsControlJustReleased(0, 38) then
                                SetNuiFocus(true, true)
                                SendNUIMessage({
                                    action = "openShop",
                                    items = GetStoreItems(shop.items)
                                })
                            end
                        end
                    end
                end
            end
        end
    end
end)

function DrawShopMarker(location)
    if not location or type(location) ~= "vector3" then return end

    local marker = Config.Marker

    DrawMarker(
        marker.type,
        location.x, location.y, location.z,
        0.0, 0.0, 0.0,
        0.0, 0.0, 0.0,
        marker.size.x, marker.size.y, marker.size.z,
        marker.color.r, marker.color.g, marker.color.b, marker.color.a,
        false, true, 2, false, nil, nil, false
    )
end

function GetStoreItems(items)
    local filtered = {}
    for _, item in pairs(items) do
        table.insert(filtered, item)
    end
    return filtered
end

RegisterNUICallback('buyBasket', function(data, cb)
    TriggerServerEvent('simeon:jobshop:server:buyBasket', data)
    cb('ok')
end)

RegisterNUICallback('close', function(_, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback('notify', function(data, cb)
    ESX.ShowNotification(data.message)
    cb('ok')
end)
