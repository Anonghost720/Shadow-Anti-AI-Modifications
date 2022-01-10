local isAllowWeapons = false

Citizen.CreateThread(function()
    TriggerEvent("shadow-aiDetection:checkPerms")
end)

RegisterNetEvent("shadow-aiDetection:checkPerms")
AddEventHandler("shadow-aiDetection:checkPerms", function()
    ESX.TriggerServerCallback("shadow-aiDetection:checkGroup",function(authed)
        if authed then
            isAllowWeapons = true
        else
            isAllowWeapons = false
        end
    end)
end)

if Config.LoopMode then
    --to Avoid Errors
    RegisterNetEvent("shadow-aiDetection:checkWeapons")
    AddEventHandler("shadow-aiDetection:checkWeapons", function()
        print('Checking Modified Weapons')
    end)
    Citizen.CreateThread(function()
        while true do
            local ped = PlayerPedId()
            if not isAllowWeapons then
                for k, v in pairs(Config.weapons) do
                    if HasPedGotWeapon(ped, k, false) then
                        local ammo = GetMaxAmmoInClip(ped, k, 1)
                        local damage = GetWeaponDamage(k)
                        if ammo > v.clipSize then
                            local playerName = GetPlayerName(PlayerId())
                            if Config.kick then
                                TriggerServerEvent('shadow-aiDetection:server:kick-player')
                            else
                                RemoveAllPedWeapons(ped, true)
                                if Config.Kill then
                                    SetEntityHealth(ped, 0)
                                end
                            end
                            TriggerServerEvent('shadow-aiDetection:sendAlert',playerName, damage, ammo, v.name)
                            break
                        elseif damage > v.damage then
                            local playerName = GetPlayerName(PlayerId())
                            if Config.kick then
                                TriggerServerEvent('shadow-aiDetection:server:kick-player', true)
                            else
                                RemoveAllPedWeapons(ped, true)
                                if Config.Kill then
                                    SetEntityHealth(ped, 0)
                                end
                            end
                            TriggerServerEvent('shadow-aiDetection:sendAlert',playerName, damage, ammo, v.name)
                            break
                        end
                    end
                end
            end
            Citizen.Wait(5000)
        end
    end)
end

if not Config.LoopMode then
    RegisterNetEvent("shadow-aiDetection:checkWeapons")
    AddEventHandler("shadow-aiDetection:checkWeapons", function()
        local ped = PlayerPedId()
        if not isAllowWeapons then
            for k, v in pairs(Config.weapons) do
                if HasPedGotWeapon(ped, k, false) then
                    local ammo = GetMaxAmmoInClip(ped, k, 1)
                    local damage = GetWeaponDamage(k)
                    if ammo > v.clipSize then
                        local playerName = GetPlayerName(PlayerId())
                        if Config.kick then
                            TriggerServerEvent('shadow-aiDetection:server:kick-player')
                        else
                            RemoveAllPedWeapons(ped, true)
                            if Config.Kill then
                                SetEntityHealth(ped, 0)
                            end
                        end
                        TriggerServerEvent('shadow-aiDetection:sendAlert',playerName, damage, ammo, v.name)
                        break
                    elseif damage > v.damage then
                        local playerName = GetPlayerName(PlayerId())
                        if Config.kick then
                            TriggerServerEvent('shadow-aiDetection:server:kick-player', true)
                        else
                            RemoveAllPedWeapons(ped, true)
                            if Config.Kill then
                                SetEntityHealth(ped, 0)
                            end
                        end
                        TriggerServerEvent('shadow-aiDetection:sendAlert',playerName, damage, ammo, v.name)
                        break
                    end
                end
            end
        end
    end)
end