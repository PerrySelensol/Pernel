local actionPanel, storage = require("../actionPanel")
local TextField = require("../widgets/textfield")
local Box = require("../primitives/box")
local Text = require("../primitives/text")

--[=============================================================================]--

local Slider = TextField:newSubclass{
	name = "slider",
	type = "fixed",

	padding = {top = 5, left = 7, bottom = 5, right = 5},

	dataMap = function(n) return assert(tonumber(n)) end
}

function Slider:dragAction(preDragValue, dragDist)
	local delta = dragDist.x
	local min, max = self.sliderMin, self.sliderMax
	if min and max then
		delta = delta*(max-min)/self.width
	else
		delta = delta/10
	end
	local increment = self.increment or 0.1
	local v = math.round((preDragValue + delta)/increment)*increment
	if min and max and preDragValue >= min and preDragValue <= max then
		storage[self.boundDataKey] = math.clamp(v, min, max)
	else
		storage[self.boundDataKey] = v
	end
end

function Slider:setStep(increment) self.increment = increment return self end

function Slider:theme(sprite, activeElement, activeTextField)
	local accent = vec(0,0,0,192)/255
	local selected = activeElement == self
	local active = activeTextField == self
	if		selected and not active	then accent = vec(20,20,20,192)/255
	elseif	selected and active		then accent = (self.color/1.5):augmented(192/255)
	elseif	not selected and active	then accent = (self.color/3):augmented(192/255)
	end

	if active then self.children[1].text = self.title.." : "..self.textBuffer.."_"
	else self.children[1].text = self.title.." : "..storage[self.boundDataKey]
	end

	sprite:fill(
		self.pos.x,
		self.pos.y,
		self.width,
		self.height,
		accent
	)

	local min, max = self.sliderMin, self.sliderMax
	if min and max then
		local color = (self.color/(selected and 1.5 or 3)):augmented(192/255)
		local a = storage[self.boundDataKey]-min
		local b = math.max(1,max-min)
		local factor = math.clamp(a/b, 0, 1)
		sprite:fill(
			self.pos.x,
			self.pos.y,
			math.floor(self.width*factor),
			self.height,
			color
		)
	end

end

return Slider