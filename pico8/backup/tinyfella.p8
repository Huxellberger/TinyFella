pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
-- simple 2d fighter for first game

-- important functions

function protect(selectedtable)
    return setmetatable({}, 
    {
        __index = selectedtable,
        __newindex = function(t, key, value)
            error
            (
                "attempting to change constant " ..
                   tostring(key) .. " to " .. tostring(value), 2
            )
        end
    })
end

-- end important functions

-- global constants

constants = 
{
    max_players = 2,
    input_definitions = { left = 0, right = 1, up = 2, down = 3, button_o = 4, button_x = 5 },
    screen_max = { x = 120, y = 120 },
    floor_bounds = { x_min = 0, x_max = 120, y_min = 80, y_max = 120 },
    gravity = -0.4,
    velocity_max = 200
}

constants = protect(constants);

-- end global constants

-- initialise core structures

function makeplayer( inx, insprite )
    return 
    { 
        x = inx, y = 20, movementdata = makemovementdata(), sprite = insprite  
    };
end

function makemovementdata()
    return
    {
        defaultmovespeed = 3, startingjumpspeed = 3, currentvelocityx = 0, currentvelocityy = 0
    };
end

players = 
{
    makeplayer( 20, 0 ),
    makeplayer( 60, 1 )
};

lineofplay = (constants.floor_bounds.y_min + constants.floor_bounds.y_max) / 2;

-- end initialise core structures

-- initialisation

function _init()
    initmatch();
end

function initmatch()
    for playerindex = 1, constants.max_players do
        players[playerindex].y = lineofplay;
    end
end

-- end initialisation

function _update()
    updatemovement();
end

function updatemovement()

    local buttoncount = #constants.input_definitions;
    local inputcount = constants.max_players * buttoncount;

    for playerindex = 1, constants.max_players do
    
        players[playerindex].y -= players[playerindex].movementdata.currentvelocityy;
        players[playerindex].movementdata.currentvelocityy += constants.gravity;
        if players[playerindex].y >= lineofplay then
            players[playerindex].y = lineofplay;
            players[playerindex].movementdata.currentvelocityy = 0;
        end

        local padindex = playerindex - 1;
        if btn( constants.input_definitions.left, padindex ) then
            players[playerindex].x -= players[playerindex].movementdata.defaultmovespeed;
        end

        if btn( constants.input_definitions.right, padindex ) then
            players[playerindex].x += players[playerindex].movementdata.defaultmovespeed;
        end

        if btn( constants.input_definitions.up, padindex ) then
            if canjump( players[playerindex] ) then
                players[playerindex].movementdata.currentvelocityy = players[playerindex].movementdata.startingjumpspeed;
            end
            -- players[playerindex].y -= players[playerindex].movementdata.defaultmovespeed;
        end

        if btn( constants.input_definitions.down, padindex ) then
            if canduck( players[playerindex] ) then
            
            end
            -- players[playerindex].y += players[playerindex].movementdata.defaultmovespeed;
        end

        players[playerindex].x = clampvalue( players[playerindex].x, 0,  constants.screen_max.x );
        players[playerindex].y = clampvalue( players[playerindex].y, 0, constants.screen_max.y );
    end
end

function canjump( inplayer )
    if inplayer.movementdata.currentvelocityy == 0 then
        if inplayer.y == lineofplay then
            return true;
        end
    end

    return false;
end

function canduck( inplayer )
    return canjump( inplayer );
end

function clampvalue( value, min, max )
    if value < min then
        value = min;
    elseif value > max then
        value = max;
    end

    return value;
end

function _draw()
    cls();
    rectfill( constants.floor_bounds.x_min, constants.floor_bounds.y_min, constants.floor_bounds.x_max, constants.floor_bounds.y_max );
    for i = 1, constants.max_players do
        spr( players[i].sprite, players[i].x, players[i].y );
    end
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700007007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700007007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
010300001335013350133501335013350263502635025350253500000032350313500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
