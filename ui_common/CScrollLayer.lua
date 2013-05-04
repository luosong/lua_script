--
-- Created by IntelliJ IDEA.
-- User: 004
-- Date: 13-3-28
-- Time: 上午10:31
-- To change this template use File | Settings | File Templates.
--

local CScrollLayer = class("CScrollLayer", function(param)
    return display.newClippingRegionNode(CCRectMake(param.x, param.y, param.width, param.height))
end)



function CScrollLayer:init(param)
    local x  = param.x
    local y  = param.y
    local wx = param.width
    local wy = param.height
    local pageSize = param.pageSize
    local rowSize  = param.rowSize
    local nodes    = param.nodes or {}
    local bVertical= param.vertical or false
    local bFreeScroll = param.bFreeScroll or false

    --CCDirector::sharedDirector()->convertToGL(pTouch->getLocationInView())

    local rowNum = math.ceil(pageSize / rowSize)
    local cellWidth = wx / rowSize
    local cellHeight = wy / rowNum

    local cellCX = cellWidth / 2
    local cellCY = cellHeight / 2
    local totoaRow = math.ceil(#nodes / rowSize)
    local totalPage = 0
    if(#nodes % pageSize == 0) then
        totalPage = #nodes / pageSize;
    else
        totalPage = math.ceil(#nodes / pageSize)
    end

    --所有节点排列总长度
    local allNodesWidth = 0
    local view = display.newLayer()
    view:setPosition(0, 0)
    self:addChild(view)

    -------------------------------------------------

    local function onHorizontalDisplay()
        local tmpX = cellCX
        local tmpY = cellCY
        if (bFreeScroll ) and nodes[1] then
            tmpX = nodes[1]:getContentSize().width / 2  + 2
        end
        for k, v in ipairs(nodes) do

            if (bFreeScroll ) and k > 1 then
                tmpX = tmpX + v:getContentSize().width + 2
            else
                if ((k - 1) % rowSize == 0) and (k > 1) then
                    tmpX = cellCX + display.width * math.floor((k - 1) / pageSize)
                    if (k - 1) % pageSize == 0 then
                        tmpY = cellCY
                    else
                        tmpY = tmpY + cellHeight
                    end

                elseif k > 1 then
                    tmpX = tmpX + cellWidth
                end
            end
            v:setPosition(tmpX + x , tmpY + y)
            view:addChild(v);
            allNodesWidth = allNodesWidth + v:getContentSize().width + 2
        end
        allNodesWidth = allNodesWidth - 2
    end



    local function onVerticalDisplay()
        local tmpX = cellCX
        local tmpY = wy - cellCY
        for k, v in ipairs(nodes) do
            if ((k - 1) % rowSize == 0) and (k > 1) then
                 tmpX = cellCX
                 if (k - 1) % pageSize == 0 then
                     if (bFreeScroll) then
                         tmpY = tmpY - cellHeight
                     else
                         tmpY = wy - cellCY - display.height * math.floor((k - 1) / pageSize)
                     end

                else
                    tmpY = tmpY - cellHeight
                end
            elseif (k > 1) then
                tmpX = tmpX + cellWidth;
            end
            --v:setPosition(tmpX + x - v:getContentSize().width / 2, tmpY + y - v:getContentSize().height / 2)
            v:setAnchorPoint(CCPointMake(0, 0))
            --v:setPosition(tmpX + x, tmpY + y)
            v:setPosition(tmpX + x, tmpY + y)
            view:addChild(v);
        end
    end

    local ptBeginPos   = {x = 0, y = 0 }
    local ptPrePos     = {x = 0, y = 0}
    local currentPage  = 1
    local localPosition = {x = 0, y = 0 }
    local bIsMove = true

    self.setCurrentNode = function(sender, index)
        local nodeWidth = nodes[1]:getContentSize().width  + 2
        local currentPage = math.ceil(index / pageSize)
        if currentPage >= totalPage then
            localPosition.x =  -allNodesWidth + wx
        else
            local x = (currentPage - 1) * rowSize * nodeWidth
            localPosition.x = -x
        end

        view:setPosition(localPosition.x, 0)
    end

    local function onHorizontalScroll(tx, ty)
        local dis = tx - ptBeginPos.x
        local cx, cy = view:getPosition()

        if bFreeScroll then
            localPosition.x = localPosition.x + dis
            if (localPosition.x > 0) then
                localPosition.x = 0
            elseif localPosition.x < -allNodesWidth + wx then
                localPosition.x =  -allNodesWidth + wx
            end
        else
            if (dis >= wx / 3) then
                if (currentPage > 1) then
                    localPosition.x = localPosition.x + display.width;
                    currentPage = currentPage - 1
                end
            elseif (dis <= -wx / 3) then
                if (currentPage < totalPage) then
                    localPosition.x = localPosition.x - display.width;
                    currentPage = currentPage + 1
                end
            end
        end

        transition.moveTo(view, {time = 0.2, x = localPosition.x, y = localPosition.y})
    end

    local function onVerticalScroll(tx, ty)
        local dis = ptBeginPos.y - ty
        local cx, cy = view:getPosition()

        if bFreeScroll then

            localPosition.y = localPosition.y - dis
            if (localPosition.y <= 0) or totoaRow <= rowNum then
                localPosition.y = 0
            elseif localPosition.y > (totoaRow - rowNum) * cellHeight then
                localPosition.y =  (totoaRow - rowNum) * cellHeight
            end
        else
            if (dis <= -wy / 4)  then
                if (currentPage < totalPage ) then
                    localPosition.y = localPosition.y + display.height;
                    currentPage = currentPage + 1
                end
            elseif (dis >= wx / 4)  then
                if (currentPage > 1 ) then
                    localPosition.y = localPosition.y - display.height;
                    currentPage = currentPage - 1
                end
            end
        end


        transition.moveTo(view, {time = 0.2, x = localPosition.x, y = localPosition.y})
    end

    local touchNode = nil
    local function onTouchBegin(tx, ty)
        bIsMove = false
        if CCRectMake(x, y, wx, wy):containsPoint(self:convertToNodeSpace(CCPointMake(tx, ty))) then
            ptBeginPos.x = tx
            ptBeginPos.y = ty
            ptPrePos.x = tx
            ptPrePos.y = ty

            for k, v in ipairs(nodes) do
                --printf(v:boundingBox().origin.x .. "   Y:" .. v:boundingBox().origin.y .. "  width:" ..v:boundingBox().size.width)
                if v:boundingBox():containsPoint(v:convertToNodeSpace(CCPointMake(tx, ty))) then
                    touchNode = v
                    touchNode:setColor(ccc3(100, 100, 100))
                    break
                end
            end

            return true
        else
            return false
        end
    end

    local function onTouchMoved(tx, ty)

        local cx, cy = view:getPosition()
        local dis = tx - ptPrePos.x
        if (bVertical) then
            dis = ty - ptPrePos.y
        else
            dis = tx - ptPrePos.x
        end

        if (dis > 5 or dis < -5) then
            bIsMove = true
            if (bVertical) then
                view:setPosition(CCPointMake(cx, cy + dis))
            else
                view:setPosition(CCPointMake(cx + dis, cy))
            end

            ptPrePos.x = tx
            ptPrePos.y = ty
            if (touchNode) ~= nil then
                touchNode:setColor(ccc3(255, 255, 255))
            end
        end
    end

    local function onTouchEnded(tx, ty)

        if (bVertical) then
            onVerticalScroll(tx, ty)
        else
            onHorizontalScroll(tx, ty)
        end

        if (bIsMove == false) then
            if (touchNode ~= nil) then
                touchNode:onTouch(touchNode)
                touchNode:setColor(ccc3(255, 255, 255))
                touchNode = nil
            end

        end
    end

    local function onTouch(eventType, tx, ty)

        if eventType == "began" then
            return onTouchBegin(tx, ty)
        elseif eventType == "moved" then
            onTouchMoved(tx, ty)
        elseif eventType == "ended" then
            onTouchEnded(tx, ty)
        end
    end



    ------------------------------------------------------------------
    view:setTouchEnabled(true)
    view:registerScriptTouchHandler(onTouch, false, -128, true)

    if (bVertical) then

        onVerticalDisplay()
    else
        onHorizontalDisplay()
    end
end


function CScrollLayer:ctor(param)
    printf("------------------type" .. type(param))
    self:init(param)
end

return CScrollLayer

