local bouncing_buttonButton = nil

local bouncing_buttonWindow = nil

local console_color =  {r = 255, g = 0, b = 255, a = 255}

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
    if shift_event then
        shift_event:cancel()
        shift_event = nil
    end
end

function show()
    bouncing_buttonWindow:setVisible(true)
    bouncing_buttonButton:setOn(true)
    shift_event = scheduleEvent(
        function() 
            shift_button_left(bouncing_buttonWindow:getChildById("Jump"),
                bouncing_buttonWindow,
                shift_speed,
                shift_delay)
        end, shift_delay)
end

function shift_button_left(jumpButton, window, speed, delay)
    if window and window:isVisible() then
        local windowPosition = window:getPosition()
        local function loopingMovement(currentX)
            local winWidth = window:getWidth()
            if currentX < windowPosition.x+jumpButton:getMarginLeft() then
                currentX = windowPosition.x+winWidth - jumpButton:getMarginRight()
            end
            return currentX
        end
        local jumpButtonPosition = jumpButton:getPosition()
        jumpButton:move(loopingMovement(jumpButtonPosition.x - speed), jumpButtonPosition.y)
        shift_event = scheduleEvent(function() shift_button_left(jumpButton, window, speed, delay) end, delay)
        return
    end
    if shift_event then
        shift_event:cancel()
        shift_event = nil
    end
end

function bouncing_button()
    if bouncing_buttonButton:isOn() then
        local jumpButton = bouncing_buttonWindow:getChildById("Jump")
        local windowPosition = bouncing_buttonWindow:getPosition()
        local randomPosition = { x = windowPosition.x+bouncing_buttonWindow:getWidth()-jumpButton:getMarginLeft(),
                                y = (math.random(windowPosition.y+jumpButton:getMarginRight(),
                                windowPosition.y+bouncing_buttonWindow:getHeight()-marginForSpawn)) }
        jumpButton:setPosition(randomPosition)
    end
end

function terminate()
    bouncing_buttonButton:destroy()
    bouncing_buttonWindow:destroy()
end