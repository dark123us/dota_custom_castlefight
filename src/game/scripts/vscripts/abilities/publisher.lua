-- local Logger = require("vendors.debug-dota.dotalogging")
-- local log = Logger()

local AbilityPublisher = {
    abilities = {},
    listeners = {},
    idlistener = 0,
}

function AbilityPublisher:addAbility(name)
    table.insert(self.abilities, name)
end

function AbilityPublisher:notify(name, params)
    for _, l in ipairs(self.listeners) do
        log:debug(l)
        l.listener(name, params)
    end
end

function AbilityPublisher:subscribe(listener)
    self.idlistener = self.idlistener + 1
    table.insert( self.listeners, {
        id = self.idlistener,
        listener = listener
    })
    return self.idlistener
end

function AbilityPublisher:unsubscribe(idlistener)
    local index = self:getIndex(idlistener)
    if index == nil then return end
    table.remove( self.listeners, index)
end

function AbilityPublisher:heroActivateAbility(entity)
    if entity:IsRealHero() then
        for e in #self.abilities do
            if entity:HasAbility(e) then
                entity:FindAbilityByName(e):SetLevel(1)
            end
        end
    end
    return self
end

function AbilityPublisher:getIndex(idlistener)
    local index = 0
    for i, v in ipairs(self.listeners) do
        if v.id == idlistener then
            index = i
            break
        end
    end
    return index
end

return AbilityPublisher
