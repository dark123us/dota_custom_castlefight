local Logger = require("lib.dota-lua-debug.debug").logging
local log = Logger()

local ECS = require("lib.dota-ecs.ecs")

local HERO = "npc_dota_hero_windrunner"
function setAbility(entity, abilityName)
    if entity:IsRealHero() and entity:HasAbility(abilityName) then
        entity:FindAbilityByName(abilityName):SetLevel(1)
    end
end

function HandleNpcSpawned(entityIndex)
    local entity = EntIndexToHScript(entityIndex)
    setAbility(entity, "Ability1")
    setAbility(entity, "Ability2")
end

local setAbilityForHero = function()
    local maxPlayers = 5
    for teamNum = DOTA_TEAM_GOODGUYS, DOTA_TEAM_BADGUYS do
        for i=1, maxPlayers do
            local playerID = PlayerResource:GetNthPlayerIDOnTeam(teamNum, i)
            log:debug(string.format("player %s %s %s", playerID, i, teamNum))
            if playerID ~= nil then
                if not PlayerResource:HasSelectedHero(playerID) then
                    local hPlayer = PlayerResource:GetPlayer(playerID)
                    if hPlayer ~= nil then
                        log:debug(hPlayer)
                        hPlayer:MakeRandomHeroSelection()
                    end
                end
            end
        end
    end
end

function randomForNoHeroSelected()
    log:debug("RandomForNoHeroSelected")
    --NOTE: GameRules state must be in HERO_SELECTION or STRATEGY_TIME to pick heroes
    --loop through each player on every team and random a hero if they haven't picked
    local player = 1
    local hero = HERO
    PrecacheUnitByNameAsync(
        hero,
        function()
            PlayerResource:ReplaceHeroWith( player, hero, 0, 0 )
        end,
        player)


    local maxPlayers = 5
    for teamNum = DOTA_TEAM_GOODGUYS, DOTA_TEAM_BADGUYS do
        for i=1, maxPlayers do
            local playerID = PlayerResource:GetNthPlayerIDOnTeam(teamNum, i)
            log:debug(string.format("player %s %s %s", playerID, i, teamNum))
            if playerID ~= nil then
                if not PlayerResource:HasSelectedHero(playerID) then
                    local hPlayer = PlayerResource:GetPlayer(playerID)
                    if hPlayer ~= nil then
                        log:debug(hPlayer)
                        hPlayer:MakeRandomHeroSelection()
                    end
                end
            end
        end
    end
end

local Setup = {}

function Setup:Init()

end

function Setup:Activate()
	local mode = GameRules:GetGameModeEntity()
    log:debug('mode is ' .. tostring(mode))
    log:debug({GameRules=GameRules})
    -- GameRules:GetGameModeEntity():SetThink( "OnThink", self, "GlobalThink", 2 )
    GameRules:EnableCustomGameSetupAutoLaunch(true)
    GameRules:SetCustomGameSetupAutoLaunchDelay(0)
    GameRules:SetCustomGameSetupTimeout(10)
    GameRules:SetHeroSelectionTime( 10 )
    GameRules:SetStrategyTime( 0.0 )
    GameRules:SetShowcaseTime( 0.0 )
    GameRules:SetPreGameTime( 0.0 )
    GameRules:SetGoldTickTime(999999)
    GameRules:SetGoldPerTick(0)          
    GameRules:SetHeroSelectPenaltyTime(5)

    mode:SetCustomGameForceHero("npc_dota_hero_windrunner")

    ListenToGameEvent("game_rules_state_change", Dynamic_Wrap(self, "OnStateChange"), self)
    ListenToGameEvent('npc_spawned', function(event) HandleNpcSpawned(event.entindex) end, nil)

    ECS.event.subscribe("Ability1", function(data) log:debug('a1') end)
    ECS.event.subscribe("Ability2", function(data) log:debug('a2') end)
end

function Setup:OnStateChange()
    --random hero once we reach strategy phase
    log:debug(string.format("OnStateChange %s %d", GameRules:State_Get(), DOTA_GAMERULES_STATE_STRATEGY_TIME))
    if GameRules:State_Get() == DOTA_GAMERULES_STATE_STRATEGY_TIME then
        randomForNoHeroSelected()
    end
end


return Setup
