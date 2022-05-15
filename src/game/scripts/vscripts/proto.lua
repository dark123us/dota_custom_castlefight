local val = {}


function val:new()
    print("hello")
    self.zones = {}
    self.name_building_place = "building_place"
    self:init()
    self:initevents()
    return self
end

function val:init()
    print("start init")
    --DeepPrintTable(self.zones)
    print("end init")
end

-- https://github.com/SteamDB2/Dota-2/blob/17dad4e449aa9c09f7a8574f6d60ecb9d1d56dc5/game/dota_addons/hero_demo/scripts/vscripts/events.lua

function val:initevents()
    CustomGameEventManager:RegisterListener("onStartBuilding", function (eventSourceIndex, data)
        print("onStartBuilding ", eventSourceIndex)
        -- DeepPrintTable(data)
        local player = PlayerResource:GetPlayer(data.PlayerID)
        print('player=', data.PlayerID)
        self:sendBuildingBound(player)
    end)
end

function val:createGhost()
    local model_location = Vector(11000,11000,0)
    local name = npc_barracks

    local building = CreateUnitByName(name, model_location, false, playersHero, player, playersHero:GetTeamNumber())
    building:SetControllableByPlayer(playerID, true)
    building:SetNeverMoveToClearSpace(true)
    building:SetOwner(playersHero)
    building:SetAbsOrigin(model_location)

    return building
end

function val:sendBuildingBound(player)
    local e = Entities:FindAllByClassname("trigger_dota")
    self.zones = {}
    for _, v in ipairs(e) do
        if v:GetName():match(self.name_building_place) then
            
            local xy1 = v:GetAbsOrigin() + v:GetBounds().Mins
            local xy2 = v:GetAbsOrigin() + v:GetBounds().Maxs
            -- print(xy1, xy2)
            local tmp = {min={x=xy1.x, y=xy1.y}, max={x=xy2.x, y=xy2.y}}
            self.zones[v:GetName()] = tmp
            -- print(v:GetName(), v:GetBounds().Mins, v:GetBounds().Maxs, v:GetAbsOrigin())
        end
    end
    --CustomGameEventManager:Send_ServerToPlayer(player, "on_building_bound", self.zones)
    CustomGameEventManager:Send_ServerToAllClients(
        "onBuildingBound", 
        {zones = self.zones, ghostEntityIndex = ghostEntityIndex})
    print('zones ', self.zones, player)
end

return function() return val:new() end