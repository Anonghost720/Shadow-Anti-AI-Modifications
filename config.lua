Config = {}

--AI DETECTION CONFIG
--Run in while loop mode, runs every 5 seconds checks less performance
--If set to false will only run when player 
--Kills another player.
Config.LoopMode = false

--Milliseconds to sleep
Config.SleepMilliSeconds = 5000

Config.BypassRoles = {
    'admin',
    'superadmin'
}

Config.weapons = {
    --These are the default values, if you use a custom weapons.meta file, change these accordingly!
    [`WEAPON_APPISTOL`] = {clipSize = 18, damage = 28.0, name = 'AP PISTOL'},
    [`WEAPON_COMBATPISTOL`] = {clipSize = 12, damage = 27.0, name = 'COMBAT PISTOL'},
}

--Kick the player on detection?
Config.kick = true
--Kill the player on detection?
Config.Kill = true
--Send Alert Message to discord
Config.discordAlert = true
--Discord webhhook
Config.discordWebhook = ''
--Discord webhhook
Config.discordBotName= 'Shadow Anti AI'
--Kicked reason messages
Config.kickReasons = {
    ammo = 'Shadow [Anti AI] Has Kicked You For Having Your Ammo Clip Size Modified',
    damage = 'Shadow [Anti AI] Has Kicked You For Having Your Weapon Damage Modified'
}
