
--[[

 @Author shan 
 @Date:

]]

require("ResourceMgr")
require("data/heros_gs")
require("data/equipments_gs")
require("data/skills_gs")
require("data/heroRelations_gs")
require("data/relations_gs")

local CCollectionInfoScene = class("CCollectionInfoScene", function ( itemID, itemtype )
        
        return display.newLayer()
		-- return display.newScene("CCollectionInfoScene")
end)



function CCollectionInfoScene:ccTouchBegan( pTouch, pEvent )
    return true
end

function CCollectionInfoScene:ctor( itemID, itemtype )

    -- disable the other nodes touch event
    function onTouch( event, x, y )
        if(event == "began") then
            return true
        end
    end
    self:setTouchEnabled(true)
    self:registerScriptTouchHandler(onTouch, false, -128, true)


	local rootNode = display.newNode()
	self:addChild(rootNode)
	local bg = display.newSprite("bg.png")
	bg:setPosition(display.width/2 + 100, display.height/2)
	rootNode:addChild(bg)

	local baseLayer = require("CBorderLayer").new()
    rootNode:addChild(baseLayer)


    -- split line

    for i=1,2 do
        local splitLine = ResourceMgr:getUISprite("board12")
        splitLine:setPosition( display.width-i*splitLine:getContentSize().width/2 - (i-1)*splitLine:getContentSize().width/2, display.height * 12/40)
        rootNode:addChild(splitLine)
    end


    -- collection bg
    -- local collectionBG = ResourceMgr:getUISprite("board11")
    -- collectionBG:setPosition(display.width * 11/40, display.height * 18/40)
    -- rootNode:addChild(collectionBG)

    -- local collect = ResourceMgr:getSprite(heroID)
    -- collect:setPosition(collectionBG:getContentSize().width/2, collectionBG:getContentSize().height/2)
    -- collectionBG:addChild(collect)

    local indata = {}
    local it = 0


    if(itemtype == CollectionType.HERO) then
        indata = BaseData_heros[itemID]
        it = ItemShowType.BASE_HEROS_INFO
    elseif(itemtype == CollectionType.EQUIP) then
        indata = BaseData_equipments[itemID]
        it = ItemShowType.BASE_EQUIP_INFO
    elseif(itemtype == CollectionType.SKILL) then
        indata = BaseData_skills[itemID]
        it = ItemShowType.BASE_EQUIP_INFO
    end

    local cc = (require("possessions.CDetailItemSprite").new(true, indata, it))
    cc:setPosition(require("FuncHelper"):getRelativeX(11), require("FuncHelper"):getRelativeY(18))
    rootNode:addChild(cc)

    -- collect description
    local descBG = ResourceMgr:getUISprite("board13")
    descBG:setPosition(display.width * 28.5 /40, display.height * 28/40)

    local textDimension = CCSizeMake(descBG:getContentSize().width, descBG:getContentSize().height)
    local descText = ui.newTTFLabel({
                                            text = indata.str_des, 
                                            dimensions = textDimension,
                                            color = ccc3(0,0,255),
                                            textAlign = ui.TEXT_ALIGN_LEFT,
                                            textValign = ui.TEXT_VALIGN_TOP,
                                            x = 2,
                                            y = descBG:getContentSize().height/2
                                            })

    descBG:addChild(descText)
    rootNode:addChild(descBG)

    -- button close
    local buttonClose = CSingleImageMenuItem:create(ResourceMgr:getUISprite("button_close"))
    buttonClose:setPosition(display.width-buttonClose:getContentSize().width, display.height-buttonClose:getContentSize().height)
    buttonClose:registerScriptTapHandler(function ( ... )
        self:removeFromParentAndCleanup(true)
        -- display.replaceScene(require("business_system.CGameCollectionScene").new())
    end)


    local menu = ui.newMenu({buttonClose})
    rootNode:addChild(menu)
    -- member hero info buttons
    if(it == ItemShowType.MEMBER_HEROS_INFO) then
        local buttonChange = CSingleImageMenuItem:create(ResourceMgr:getUISprite("button_bg"))
        buttonChange:setPosition(descBG:getPositionX()-buttonChange:getContentSize().width/2, 
            descBG:getPositionY()-descBG:getContentSize().height/2 - buttonChange:getContentSize().height)
        buttonChange:registerScriptTapHandler(function ( ... )
            -- body
            --fixme
        end)

        local buttonPass = CSingleImageMenuItem:create(ResourceMgr:getUISprite("button_bg"))
        buttonPass:setPosition(descBG:getPositionX()+buttonPass:getContentSize().width/2 , 
            descBG:getPositionY()-descBG:getContentSize().height/2 - buttonPass:getContentSize().height)
        buttonPass:registerScriptTapHandler(function ( ... )
           -- body
        end)

       menu:addChild(buttonChange)
       menu:addChild(buttonPass)
    end

    -- relationship description
    function effectText( reldata )
        if(reldata == nil) then
            return ""
        end

        local prefix_text = "提高"
        local text = ""
        if(reldata.effect_type == 1) then            
            text = "攻击" .. prefix_text .. reldata.value .. "%"
        elseif(reldata.effect_type == 2) then
            text = "防御" .. prefix_text .. reldata.value .. "%"
        elseif(reldata.effect_type == 3) then
            text = "内力" .. prefix_text .. reldata.value .. "%"
        elseif(reldata.effect_type == 4) then
            text = "攻击" .. prefix_text .. reldata.value .. "点"
        elseif(reldata.effect_type == 5) then
            text = "防御" .. prefix_text .. reldata.value .. "点"
        elseif(reldata.effect_type == 6) then
            text = "内力" .. prefix_text .. reldata.value .. "点"
        end

        return text
    end
    function genRelationText( indata )
        print("===========genRelationText============")
        local text = {}
        local textIndex = 1

        for k,v in pairs(indata) do
            if(type(v) == "table") then
                if(v[1] ~= 0) then
                    local name = ""
                    local prefix_text = ""
                    local postfix_text = ""
                    local effText = ""
                    if(v[1] == 1) then  -- hero
                        local len = #v
                        for i=3,len do
                            local n = BaseData_heros[v[i]].str_name 
                            if(i ~= len) then
                                n = n .. ","
                            end

                            name = name .. n
                        end
                        -- name = BaseData_heros[v[2]].str_name
                        prefix_text = "和"
                        postfix_text = "一起上阵"   
                        effText = effectText(BaseData_relations[v[2]])  
                        print("==========name============".. name.. "," .. textIndex)                                             
                    elseif(v[1] == 2) then  -- skill
                    elseif(v[1] == 3) then  -- equip
                    end
                text[textIndex] = prefix_text .. name .. postfix_text .. effText 
 
                -- only table add
                textIndex = textIndex + 1    
                end
            end
            
        end

        return text
    end

    -- relationship text
    if(itemtype == CollectionType.HERO) then
        local heroRelation = BaseData_heroRelations[itemID]    
        if(heroRelation ~= nil) then
            local text = genRelationText(heroRelation)

            local len = #text

            for i,v in ipairs(text) do
                local relationText = ui.newTTFLabel({
                                            text = text[i], 
                                            size = 20,
                                            dimensions = textDimension,
                                            textAlign = ui.TEXT_ALIGN_LEFT,
                                            textValign = ui.TEXT_VALIGN_TOP,
                                            color = ccc3(0,0,255),
                                            x = display.width/2,
                                            y = display.height/3 - (i-1) * 50
                                            })
                self:addChild(relationText) 
            end

            print(text[1])
        end
    end    

end







--[[end class]]
return CCollectionInfoScene