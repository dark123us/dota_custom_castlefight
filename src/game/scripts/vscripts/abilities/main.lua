-- local Logger = require("vendors.debug-dota.dotalogging")
-- local log = Logger()
local AbilityPublisher = require("abilities/publisher")

AbilityPublisher:addAbility("Ability1")
AbilityPublisher:addAbility("Ability2")

Ability1 = {name = 'Ability1'}
function Ability1:OnSpellStart()
    AbilityPublisher:notify("Ability1", {from=self})
end

Ability2 = {}
function Ability2:OnSpellStart()
    AbilityPublisher:notify("Ability2", {from=self})
end
