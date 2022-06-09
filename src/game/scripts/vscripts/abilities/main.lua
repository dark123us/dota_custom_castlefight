local event = require("lib.dota-ecs.ecs").event

event:register("Ability1")
event:register("Ability2")

Ability1 = {name = 'Ability1'}
function Ability1:OnSpellStart()
    event:notify("Ability1", {from=self})
end

Ability2 = {}
function Ability2:OnSpellStart()
    event:notify('Ability2', {from=self})
end

BuildBarrack = {}
function BuildBarrack:OnSpellStart()
    event:notify('BuildBarrack', {from=self})
end
