--[=============================================================================]--

local sprite = textures:newTexture("Main_Sprite", 1920/4, 1080/4)
	:fill(0,0, 1920/4, 1080/4, vec(0,0,0,0))

local hudPart = models:newPart("HUD_ModelPart")
	:setParentType("HUD"):setVisible(false)

hudPart:newSprite("UI")
	:setVisible(true)
	:setDimensions(sprite:getDimensions())
	:setTexture(sprite, 1920/4, 1080/4)
	:setLight(15,15)

local Text_Tasks = {index = 1}
for i = 1, 20 do Text_Tasks[i] = hudPart:newText("UIText"..i):shadow(true):setVisible(false) end

return hudPart, sprite, Text_Tasks
