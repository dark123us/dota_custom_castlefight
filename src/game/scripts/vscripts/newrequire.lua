if oldrequire ~= nil then
    print('require already rewrite hook not set')
    return nil
end
print("set hook on require ")
function try(func, catch_func)
    local status, data = pcall(func)
    if not status then
        catch_func(data)
    end
    return data
end
oldrequire = require
local count = 0
function require(unit)
    print("loading", unit, count)
    count = count + 1 
    local res = nil
    local err = nil
    local paths = {'', 'lib.debug-dota-dev.', 'lib.'}

    for i, path in ipairs(paths) do
        err = nil
        res = try(function()
            return oldrequire(path .. unit)
        end, function(e)
            err = e
            print("WARNING", e)
        end)
        if err == nil then
            break
        end
    end
    count = count - 1 
    return res
end
