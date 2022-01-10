local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.kick then
    RegisterNetEvent('shadow-aiDetection:server:kick-player', function(bool)
        local src = source
        local reason = Config.kickReasons.ammo
        if bool then
            reason = Config.kickReasons.damage
        end
        print(string.format('^4[shadow-aiDetection]^0 - [%s] %s has been kicked for reason: %s', src, GetPlayerName(src), reason))
        DropPlayer(src, string.format('You have been kicked.\n\nReason: %s', reason))
    end)
end

function sendAiMessageToDiscord(message,title,color,player,damage,ammo,weapon,steamid)
  local embeds = {
        {
        ["title"] = title,
        ["description"] = message,
        ["type"] = "rich",
        ["color"] =color,
        ["footer"] =  {
        ["text"]= os.date("%d/%m/%Y %H:%M:%S"),
        },
            ["fields"] = {
                    {
                        ["name"] = "Player",
                        ["value"] = player,
                        ["inline"] = false,
                    },
                    {
                        ["name"] = "Steam ID",
                        ["value"] = steamid,
                        ["inline"] = false,
                    },
                    {
                        ["name"] = "Weapon",
                        ["value"] = weapon,
                        ["inline"] = false,
                    },
                    {
                        ["name"] = "Damage",
                        ["value"] = damage,
                        ["inline"] = false,
                    },
                    {
                        ["name"] = "Ammo",
                        ["value"] = ammo,
                        ["inline"] = false,
                    },
                },
        }
    }
  if message == nil or message == '' then return false end
  local webhook = Config.discordWebhook
  local name = Config.discordBotName
  PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

RegisterNetEvent("shadow-aiDetection:sendAlert")
AddEventHandler("shadow-aiDetection:sendAlert", function(playerName, damage, ammo, weapon)
    local identifier = GetPlayerIdentifiers(source)[1] or 'Unknown'
    local message = string.format('Player have his weapons modified, Weapon Info: Weapon: %s Damage: %s Clip Size: %s', tostring(weapon), tostring(damage), tostring(ammo))
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div class="chat-message aidetection"><i class="fas fa-baseball-ball"></i> <b><span style="color: #1ebc62">[AI MODED] {0}</span>&nbsp;<br><span style="font-size: 14px; color: #e1e1e1;">Player have his weapons modified.<br><span style="color: #23FA28">Weapon Info:</span><br><span style="color: #087EF7">Weapon: {1}</span><br><span style="color: #F74848">Damage: {2}</lspan><br><span style="color: #9B60B1">Clip Size: {3}</span></span></b></div>',                                                    
        args = { playerName, weapon, damage, ammo }
    })
    sendAiMessageToDiscord(message,'SHADOW AI DETECTION',16392995,playerName,tostring(damage),tostring(ammo),tostring(weapon),tostring(identifier))
end)

ESX.RegisterServerCallback("shadow-aiDetection:checkGroup", function(source,cb)
    if IsPlayerAceAllowed(source, "shadow-aiDetection") then
        isAllow = true
    else
        isAllow = false
    end
	cb(isAllow)
end)