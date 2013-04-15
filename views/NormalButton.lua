
local NormalButton = {}

NormalButton.TYPE_NORMAL = 1
NormalButton.TYPE_BUBBLE = 2
NormalButton.TYPE_DARKER = 3

-- create normal button
function NormalButton.new(params)
    local listener = params.listener
    local button -- pre-reference

    params.buttonType = params.buttonType or NormalButton.TYPE_NORMAL
    params.listener = function(tag)
        if params.prepare then
            params.prepare()
        end

        local function normal1(offset, time, onComplete)
            local x, y = button:getPosition()
            local size = button:getContentSize()

            local scaleX = button:getScaleX() * (size.width + offset) / size.width
            local scaleY = button:getScaleY() * (size.height + offset) / size.height

            -- transition.moveTo(button, {y = y - offset, time = time})
            transition.scaleTo(button, {
                scaleX     = scaleX,
                scaleY     = scaleY,
                time       = time,
                onComplete = onComplete,
            })
        end

        local function normal2(offset, time, onComplete)
            local x, y = button:getPosition()
            local size = button:getContentSize()

            -- transition.fadeIn(button, {time = time})
            -- transition.moveTo(button, {y = y + offset, time = time / 2})
            transition.scaleTo(button, {
                scaleX     = 1.0,
                scaleY     = 1.0,
                time       = time,
                onComplete = onComplete,
            })
        end
        local function zoom1(offset, time, onComplete)
            local x, y = button:getPosition()
            local size = button:getContentSize()

            local scaleX = button:getScaleX() * (size.width + offset) / size.width
            local scaleY = button:getScaleY() * (size.height - offset) / size.height

            transition.moveTo(button, {y = y - offset, time = time})
            transition.scaleTo(button, {
                scaleX     = scaleX,
                scaleY     = scaleY,
                time       = time,
                onComplete = onComplete,
            })
        end

        local function zoom2(offset, time, onComplete)
            local x, y = button:getPosition()
            local size = button:getContentSize()

            transition.moveTo(button, {y = y + offset, time = time / 2})
            transition.scaleTo(button, {
                scaleX     = 1.0,
                scaleY     = 1.0,
                time       = time,
                onComplete = onComplete,
            })
        end

        local function dark1( offset, time, onComplete )
            local x, y = button:getPosition()
            local size = button:getContentSize()

            button:setOpacity(100)
            -- transition.moveTo(button, {y = y + offset, time = time / 2})
            transition.scaleTo(button, {
                scaleX     = 0.9,
                scaleY     = 0.9,
                time       = time,
                onComplete = onComplete,
            })
        end 
        local function dark2( offset, time, onComplete )
            local x, y = button:getPosition()
            local size = button:getContentSize()

            button:setOpacity(255)
            -- transition.moveTo(button, {y = y + offset, time = time / 2})
            transition.scaleTo(button, {
                scaleX     = 1.0,
                scaleY     = 1.0,
                time       = time,
                onComplete = onComplete,
            })
        end 

        -- =================================================

        button:getParent():setEnabled(false)

        if(params.buttonType == NormalButton.TYPE_NORMAL) then
            normal1(20, 0.11, function()
                       normal2(20, 0.08, function()
                            button:getParent():setEnabled(true)
                            listener(tag)
                       end)
            end)
        elseif(params.buttonType == NormalButton.TYPE_BUBBLE) then
            zoom1(40, 0.08, function()
                zoom2(40, 0.09, function()
                    zoom1(20, 0.10, function()
                        zoom2(20, 0.11, function()
                            button:getParent():setEnabled(true)
                            listener(tag)
                        end)
                    end)
                end)
            end)
        elseif(buttonType == TYPE_DARKER) then
            dark1(40,0.08, function ( ... )
                dark2(40,0.08,function()
                        button:getParent():setEnabled(true)
                        listener(tag)
                    end)
            end)
        end
        
    end -- listener = function(tag)

    button = ui.newImageMenuItem(params)
    return button
end

return NormalButton
