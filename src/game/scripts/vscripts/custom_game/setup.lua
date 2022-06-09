local Logger = require("lib.dota-lua-debug.debug").logging
local log = Logger()

local ECS = require("lib.dota-ecs.ecs")
local API = require("lib.dota2_api.api")

local CONST = {
    HERO = "npc_dota_hero_windrunner"
}

function HandleNpcSpawned(entityIndex)
    local entity = API.player:EntityIndexToHandler(entityIndex)
    API.player:SetAbilityLevel(entity, "Ability1")
    API.player:SetAbilityLevel(entity, "Ability2", 1)
end

local Setup = {}

function Setup:Init()

end

function Setup:Activate()
    API.gamerules:SetEventDispatcher(ECS.event)
    API.gamerules:InitDebugMode(CONST.HERO)
    local CONST = API.gamerules:Constants()
    ECS.event:subscribe(CONST.OnStateChange, function(data) log:debug({data}) end)

    -- ListenToGameEvent("game_rules_state_change", Dynamic_Wrap(self, "OnStateChange"), self)
    ListenToGameEvent('npc_spawned', function(event) HandleNpcSpawned(event.entindex) end, nil)

    -- ECS.event:subscribe("Ability1", function(data) log:debug('a1') end)
    -- ECS.event:subscribe("Ability2", function(data) log:debug('a2') end)
end


return Setup
