local bouncing_buttonButton = nil

local bouncing_buttonWindow = nil

local marginForSpawn = 70

local shift_event
local shift_delay = 25
local shift_speed = 3

function init()
    bouncing_buttonButton = modules.client_topmenu.addRightToggleButton('Bouncing Button', tr('Bouncing Button'), '/bouncing_button/icon.png', toggle)
    bouncing_buttonButton:setOn(false)

    bouncing_buttonWindow = g_ui.displayUI('bouncing_button')
    bouncing_buttonWindow:setVisible(false)

    --get help values
    allTabs = bouncing_buttonWindow:recursiveGetChildById('allTabs')
    allTabs:setContentWidget(bouncing_buttonWindow:getChildById('optionsTabContent'))
end

function toggle()
    if bouncing_buttonButton:isOn() then
        hide()
    else
        show()
    end
end

function hide()
    bouncing_buttonWindow:setVisible(false)
    bouncing_buttonButton:setOn(false)
    -- end the button shift cycle
    if shift_event then
        shift_event:cancel()
        shift_event = nil
    end
end

function show()
    bouncing_buttonWindow:setVisible(true)
    bouncing_buttonButton:setOn(true)
    -- start the button shift event cycle
    shift_event = scheduleEvent(
        function() 
            shift_button_left(bouncing_buttonWindow:getChildById("Jump"),
                bouncing_buttonWindow,
                shift_speed,
                shift_delay)
        end, shift_delay)
end

-- A function that is used as a periodic event to shift the button
function shift_button_left(jumpButton, window, speed, delay)
    if window and window:isVisible() then
        local windowPosition = window:getPosition()
        -- an assistive function that maintains the bounds of the button within the window
        -- and loops to the opposite side when the button reaches past the bounds
        local function loopingMovement(currentX)
            local winWidth = window:getWidth()
            if currentX < windowPosition.x+jumpButton:getMarginLeft() then
                currentX = windowPosition.x+winWidth - jumpButton:getMarginRight()
            end
            return currentX
        end
        local jumpButtonPosition = jumpButton:getPosition()
        -- shifting the button by speed for each interval of delay
        jumpButton:move(loopingMovement(jumpButtonPosition.x - speed), jumpButtonPosition.y)
        -- Continue the event cycle
        shift_event = scheduleEvent(function() shift_button_left(jumpButton, window, speed, delay) end, delay)
        return
    end
    -- Clear the event cycle when the window is not visible
    if shift_event then
        shift_event:cancel()
        shift_event = nil
    end
end

-- The behavior function when the button is clicked
function bouncing_button()
    -- Need the window to be open, sanity check
    if bouncing_buttonButton:isOn() then
        -- Get all of the data we need to operate
        local jumpButton = bouncing_buttonWindow:getChildById("Jump")
        local windowPosition = bouncing_buttonWindow:getPosition()
        -- Create the random position (within the bounds of the window)
        local randomPosition = { x = windowPosition.x+bouncing_buttonWindow:getWidth()-jumpButton:getMarginLeft(),
                                y = (math.random(windowPosition.y+jumpButton:getMarginRight(),
                                windowPosition.y+bouncing_buttonWindow:getHeight()-marginForSpawn)) }
        -- Place the button at the decided location
        jumpButton:setPosition(randomPosition)
    end
end


-- Need to destroy the elements
function terminate()
    bouncing_buttonButton:destroy()
    bouncing_buttonWindow:destroy()
end