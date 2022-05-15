local lunatest = require "lunatest"
local assert_equal, assert_not_equal = lunatest.assert_equal, lunatest.assert_not_equal

local test_first = {}
function test_first.test_assert ()
	assert_equal ( 1 + 1, 2 )
end

return test_first
