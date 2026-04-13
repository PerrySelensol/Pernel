local Box = require("../primitives/box")
local Text = require("../primitives/text")

--[=============================================================================]--

local Button = Box:newSubclass{
	name = "button",

	width = 0,
	height = 0,

	type = "fixed",

	padding = {top = 5, left = 7, bottom = 5, right = 5}
}

do
	local new = Button.new
	function Button:new(o)
		o = new(self, o)
		o:addElement(Text:new())
		o.isActive = false
		return o
	end
end

function Button:theme(sprite, activeElement)
	local accent = vec(0,0,0,192)/255
	local selected = activeElement == self
	local active = self.isActive
	if		selected and not active	then accent = vec(20,20,20,192)/255
	elseif	selected and active		then accent = (self.color/1.5):augmented(192/255)
	elseif	not selected and active	then accent = (self.color/3):augmented(192/255)
	end

	sprite:fill(
		self.pos.x,
		self.pos.y,
		self.width,
		self.height,
		accent
	)

	if self.toggle then
		sprite:fill(
			self.pos.x+self.width-13,
			self.pos.y+4,
			9,
			9,
			vec(1,1,1)
		)
		sprite:fill(
			self.pos.x+self.width-12,
			self.pos.y+5,
			7,
			7,
			accent
		)
		if active then
			sprite:fill(
				self.pos.x+self.width-11,
				self.pos.y+6,
				5,
				5,
				self.color
			)
		end
	else
		sprite:fill(
			self.pos.x+1,
			self.pos.y+2,
			1,
			13,
			self.color:augmented(192/255)
		)
	end
end

function Button:onLeftClick(func) self.leftClick = func return self end
function Button:onRightClick(func) self.rightClick = func return self end
function Button:onToggle(func) self.toggle = func return self end

function Button:clickAction(button, modifier)
	if self.toggle and button == 0 then
		self.isActive = not self.isActive
		self.toggle(self.isActive)
	elseif self.leftClick and button == 0 then
		self.leftClick()
	elseif self.rightClick and button == 1 then
		self.rightClick()
	end
end

return Button