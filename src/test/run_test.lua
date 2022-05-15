-- https://github.com/silentbicycle/lunatest
local lunatest = require "lunatest"
local assert_equal, assert_not_equal = lunatest.assert_equal, lunatest.assert_not_equal

print(package.path)
package.path = package.path .. ';../game/scripts/vscripts/?.lua'
package.path = package.path .. ';../game/scripts/vscripts/?/init.lua'
print(package.path)

pcall(require, "luacov")
lunatest.suite("test_first")
lunatest.suite("test_second")
lunatest.suite("test_ecs")

lunatest:run()
