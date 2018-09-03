pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
-- Simple 2D fighter for first game

-- Important Functions

function protect(SelectedTable)
    return setmetatable({}, 
    {
        __index = SelectedTable,
        __newindex = function(t, key, value)
            error
            (
                "attempting to change constant " ..
                   tostring(key) .. " to " .. tostring(value), 2
            )
        end
    })
end

-- END Important Functions

-- Global Constants

Constants = 
{
    MAX_PLAYERS = 2,
    INPUT_DEFINITIONS = { LEFT = 0, RIGHT = 1, UP = 2, DOWN = 3, BUTTON_O = 4, BUTTON_X = 5 },
    SCREEN_MAX = { X = 120, Y = 120 }
}

Constants = protect(Constants);

-- END Global Constants

-- Initialise Core Structures

Players = 
{
    { X = 20, Y = 20, Speed = 3 },
    {  X = 60, Y = 20, Speed = 3 }
};

-- END Initialise Core Structures

-- Initialisation

function _init()

end

-- END Initialisation

function _update()
    updateMovement();
end

function updateMovement()

    local ButtonCount = #Constants.INPUT_DEFINITIONS;
    local InputCount = Constants.MAX_PLAYERS * ButtonCount;

    for PlayerIndex = 1, Constants.MAX_PLAYERS do
        local PadIndex = PlayerIndex - 1;
        if btn( Constants.INPUT_DEFINITIONS.LEFT, PadIndex ) then
            Players[PlayerIndex].X -= Players[PlayerIndex].Speed;
        end

        if btn( Constants.INPUT_DEFINITIONS.RIGHT, PadIndex ) then
            Players[PlayerIndex].X += Players[PlayerIndex].Speed;
        end

        if btn( Constants.INPUT_DEFINITIONS.UP, PadIndex ) then
            Players[PlayerIndex].Y -= Players[PlayerIndex].Speed;
        end

        if btn( Constants.INPUT_DEFINITIONS.DOWN, PadIndex ) then
            Players[PlayerIndex].Y += Players[PlayerIndex].Speed;
        end

        Players[PlayerIndex].X = clampValue( Players[PlayerIndex].X, 0,  Constants.SCREEN_MAX.X );
        Players[PlayerIndex].Y = clampValue( Players[PlayerIndex].Y, 0, Constants.SCREEN_MAX.Y );
    end
end

function clampValue( value, min, max )
    if value < min then
        value = min;
    elseif value > max then
        value = max;
    end

    return value;
end

function _draw()
    cls();
    for i = 1, Constants.MAX_PLAYERS do
        spr( i - 1, Players[i].X, Players[i].Y );
    end
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700007007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700007007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
