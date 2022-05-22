-- D:\SteamLibrary\steamapps\common\dota 2 beta\game\core\scripts\vscripts\utils
local hook_require = require("lib.dota-lua-debug.debug.hook_require")
hook_require:install()
local Logger = require("lib.dota-lua-debug.debug").logging
local log = Logger()
log:setLevel(log.DEBUG)
log:debug("---------init------------")

local args = {...}
local directory = args[1]..'.'
log:debug(directory)
local setup = require(directory.."setup")

local ECS = require("lib.dota-ecs.ecs")
log:debug("///////")
log:debug({ECS})
log:debug({setup})

local Rx = require("lib.RxLua.rx")
log:debug(tostring(Rx))

local msg = function(val)
    log:debug(val)
end

Rx.Observable.fromRange(1, 8)
  :filter(function(x) return x % 2 == 0 end)
  :concat(Rx.Observable.of('who do we appreciate'))
  :map(function(value) return value .. '!' end)
  :subscribe(msg)

if CustomGame == nil then
    CustomGame = {}
else
    CustomGame:close()
end

function CustomGame:Activate()
    log:debug("ACTIVATE")
    setup:init()
	GameRules:GetGameModeEntity():SetThink( "OnThink", self )
	-- local mode = GameRules:GetGameModeEntity()
    -- print('mode is ', mode)
    -- print(GameRules:GetGameModeEntity())
    -- log:debug({GameRules=GameRules})
	-- -- GameRules:GetGameModeEntity():SetThink( "OnThink", self, "GlobalThink", 2 )
	-- GameRules:GetGameModeEntity():SetThink( "OnThink", self )
	-- GameRules:EnableCustomGameSetupAutoLaunch(true)
	-- GameRules:SetCustomGameSetupAutoLaunchDelay(0)
	-- GameRules:SetCustomGameSetupTimeout(10)
	-- GameRules:SetHeroSelectionTime( 10 )
	-- GameRules:SetStrategyTime( 0.0 )
	-- GameRules:SetShowcaseTime( 0.0 )
	-- GameRules:SetPreGameTime( 0.0 )
	-- GameRules:SetGoldTickTime(999999)
	-- GameRules:SetGoldPerTick(0)          
	-- GameRules:SetHeroSelectPenaltyTime(5)

    -- mode:SetCustomGameForceHero("npc_dota_hero_windrunner")
	-- -- mode:SetCustomGameForceHero("npc_dota_hero_custom_windrunner")
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


