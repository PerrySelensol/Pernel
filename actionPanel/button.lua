local Box = require("./box")
local Text = require("./text")

--[=============================================================================]--

local Button = Box:new{
	name = "button",

	width = 0,
	height = 0,

	type = "fixed",

	padding = {top = 5, left = 7, bottom = 5, right = 5}
}
Button.color = nil

do
	local new = Button.new
	function Button:new(o)
		o = new(self, o)
		o:addElement(Text:new())
		o.isActive = false
		return o
	end
end

function Button:theme(sprite, elementUnderCursor)
	local accent = vec(0,0,0,192)/255
	local selected = elementUnderCursor == self
	local active = self.isActive
	if		selected and not active	then accent = vec(20,20,20,192)/255
	elseif	selected and active		then accent = (self.color/1.5):augmented(192/255)
	elseif	not selected and active	then accent = (self.color/3):augmented(192/255)
	end

	sprite:fill(
		self.pos.x,
		self.pos.y,
		1,
		self.height,
		self.color
	)
	sprite:fill(
		self.pos.x+1,
		self.pos.y,
		self.width-1,
		self.height,
		accent
	)
end

function Button:clickAction(button, action, modifier)
	if self.toggle and action == 1 and button == 0 then
		self.isActive = not self.isActive
		self.toggle(self.isActive)
	elseif self.leftClick and action == 1 and button == 0 then
		self.leftClick()
	elseif self.rightClick and action == 1 and button == 1 then
		self.rightClick()
	end
end

return Button