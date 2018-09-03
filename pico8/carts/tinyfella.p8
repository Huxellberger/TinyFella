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
    MAX_PLAYERS = 1,
    INPUT_DEFINITIONS = { LEFT = 0, RIGHT = 1, UP = 2, DOWN = 3, BUTTON_O = 4, BUTTON_X = 5 },
    SCREEN_MAX = { X = 120, Y = 120 }
}

Constants = protect(Constants);

-- END Global Constants

-- Initialise Core Structures

FirstPlayer = { X = 20, Y = 20, Sprite = 0, Speed = 3 };

-- END Initialise Core Structures

-- Initialisation

function _init()
    
end

-- END Initialisation

function _update()
    updateMovement();
end

function updateMovement()
    if btn( Constants.INPUT_DEFINITIONS.LEFT ) then
        FirstPlayer.X -= FirstPlayer.Speed;
    end

    if btn( Constants.INPUT_DEFINITIONS.RIGHT ) then
        FirstPlayer.X += FirstPlayer.Speed;
    end

    if btn( Constants.INPUT_DEFINITIONS.UP ) then
        FirstPlayer.Y -= FirstPlayer.Speed;
    end

    if btn( Constants.INPUT_DEFINITIONS.DOWN ) then
        FirstPlayer.Y += FirstPlayer.Speed;
    end

    FirstPlayer.X = clampValue( FirstPlayer.X, 0,  Constants.SCREEN_MAX.X );
    FirstPlayer.Y = clampValue( FirstPlayer.Y, 0, Constants.SCREEN_MAX.Y );
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
    spr( FirstPlayer.Sprite, FirstPlayer.X, FirstPlayer.Y );
end

