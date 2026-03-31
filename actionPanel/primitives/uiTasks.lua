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

-- Hot fix: R & B channels are swapped in 1.21.4 --
	if client.getVersion() == "1.21.4" then
		local oldSprite = sprite
		sprite = {
			fill = function(self, x, y, width, height, ...)
				local r, g, b, a = ...
				if r.x then
					oldSprite:fill(x, y, width, height, r.zyxw)
				else
					oldSprite:fill(x, y, width, height, b, g, r, a)
				end
				return self
			end,
			update = function(self) oldSprite:update() return self end
		}
	end
-- ============================================== --

return hudPart, sprite, Text_Tasks
