-- local Debug = require("lib.dota-lua-debug")
-- 
-- local vals = ''
-- for k, v in pairs(Debug) do
--     vals = vals ..'; '.. k .. ':' .. tostring(v)
-- end
-- print(vals)
-- Debug.hook_require.install()
-- local Logger = Debug.logging
--
local hook_require = require("lib.dota-lua-debug.hook_require")
hook_require:install()
local Logger = require("lib.dota-lua-debug.logging")
print(package.path)
local log = Logger()
log:setLevel(log.DEBUG)
log:debug({log})
-- local Logger = require("lib.debug-dota.dotalogging")
-- local log = Logger()
log:debug("init")


local ECS = require("lib.dota-ecs")
log:debug("///////")
log:debug({ECS})

require("custom_game.test")



if CustomGame == nil then
    CustomGame = {}
else
    CustomGame:close()
end

function CustomGame:Activate()
    log:debug("ACTIVATE")
	local mode = GameRules:GetGameModeEntity()
    print('mode is ', mode)
    print(GameRules:GetGameModeEntity())
    log:debug({GameRules=GameRules})
	-- GameRules:GetGameModeEntity():SetThink( "OnThink", self, "GlobalThink", 2 )
	GameRules:GetGameModeEntity():SetThink( "OnThink", self )
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
	-- mode:SetCustomGameForceHero("npc_dota_hero_custom_windrunner")
end

function CustomGame:OnThink()
    log:debug("onthink")
	if GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		--print( "Template addon script is running." )
	elseif GameRules:State_Get() >= DOTA_GAMERULES_STATE_POST_GAME then
		return nil
	end
	return 10
end

function CustomGame:close()
end

return CustomGame



