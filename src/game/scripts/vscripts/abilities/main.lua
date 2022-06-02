-- local Logger = require("vendors.debug-dota.dotalogging")
-- local log = Logger()
local event = require("lib.dota-ecs.ecs").event

event:register("Ability1")
event:register("Ability2")

-- AbilityPublisher:addAbility("Ability1")
-- AbilityPublisher:addAbility("Ability2")

Ability1 = {name = 'Ability1'}
function Ability1:OnSpellStart()
    event:notify("Ability1", {from=self})
end

Ability2 = {}
function Ability2:OnSpellStart()
    event:notify('Ability2', {from=self})
    -- AbilityPublisher:notify("Ability2", {from=self})
end
