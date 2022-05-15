local Logger = require("lib.dota-lua-debug.logging")
local log = Logger()

local setup = {}

function setup:init()
	local mode = GameRules:GetGameModeEntity()
    log:debug('mode is ' .. tostring(mode))
    log:debug(tostring(GameRules:GetGameModeEntity()))
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
end


return setup
