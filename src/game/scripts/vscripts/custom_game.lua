local args = {...}
local directory = args[1]..'.'

local hook_require = require("lib.dota-lua-debug.debug.hook_require")
hook_require:install()
local Logger = require("lib.dota-lua-debug.debug").logging
local log = Logger()
log:setLevel(log.DEBUG)
log:debug("---------init------------")

local CustomGame = {}

local ECS = require("lib.dota-ecs.ecs")
local setup = require(directory.."setup")


function CustomGame:Init()
    setup:Init()
end


-- local Rx = require("lib.RxLua.rx")
-- log:debug(tostring(Rx))
-- 
-- local msg = function(val)
--     log:debug(val)
-- end
-- 
-- Rx.Observable.fromRange(1, 8)
--   :filter(function(x) return x % 2 == 0 end)
--   :concat(Rx.Observable.of('who do we appreciate'))
--   :map(function(value) return value .. '!' end)
--   :subscribe(msg)

-- if CustomGame == nil then
--     CustomGame = {}
-- else
--     CustomGame:close()
-- end

function CustomGame:Activate()
    log:debug("ACTIVATE")
    setup:Activate()
	GameRules:GetGameModeEntity():SetThink( "OnThink", self )
    ECS.event:subscribe('Ability1', function(data) log:debug('a1') end)
    ECS.event:subscribe('Ability2', function(data) log:debug('a2') end)
    for k,v in pairs(ECS.event.events()) do
        log:debug({k,v})
    end
    log:debug({ability=ECS.event:events().Ability1})
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


function CustomGame:Close()
end

return CustomGame


