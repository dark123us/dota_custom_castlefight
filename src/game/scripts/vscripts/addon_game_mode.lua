-- dota_launch_custom_game castlefight castle_story_1 jointeam good
print('============= INITIALIZE ============== addon_game_mode')
local customGame = require "custom_game"
print(customGame)
customGame:Init()
function Precache( context )
    --[[
        Precache things we know we'll use.  Possible file types include (but not limited to):
        PrecacheResource( "model", "*.vmdl", context )
        PrecacheResource( "soundfile", "*.vsndevts", context )
        PrecacheResource( "particle", "*.vpcf", context )
        PrecacheResource( "particle_folder", "particles/folder", context )
    ]]
end

-- Create the game mode when we activate
function Activate()
    customGame:Activate()
end
