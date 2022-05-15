local lunatest = require "lunatest"
local assert_equal, assert_not_equal = lunatest.assert_equal, lunatest.assert_not_equal
local assert_nil, assert_not_nil = lunatest.assert_nil, lunatest.assert_not_nil


local game = require "init"

local test_ecs = {}


function test_ecs.test_create_world()
    print('+++ game', game)
    print('+++ game.ecs', game.ecs)
    print('+++ game.ecs.world', game.ecs.world)
    assert_not_nil(game)

end

return test_ecs
