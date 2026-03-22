local actionPanel, storage = require("../actionPanel")
local Box = require("../primitives/box")
local Text = require("../primitives/text")

--[=============================================================================]--

local TextField = Box:new{
	name = "textbox",

	width = 0,
	height = 0,

	type = "fixed",

	padding = {top = 5, left = 7, bottom = 5, right = 5}
}
TextField.color = nil

do
	local new = TextField.new
	function TextField:new(o)
		o = new(self, o)
		o:addElement(Text:new())
		return o
	end
end

function TextField:clickAction(button, action, modifier)
	if action == 1 and button == 0 then
		actionPanel:setTextField(self)
	end
end

function TextField:theme(sprite, activeElement, activeTextField)
	local accent = vec(0,0,0,192)/255
	local selected = activeElement == self
	local active = activeTextField == self
	if		selected and not active	then accent = vec(20,20,20,192)/255
	elseif	selected and active		then accent = (self.color/1.5):augmented(192/255)
	elseif	not selected and active	then accent = (self.color/3):augmented(192/255)
	end

	if active then self.children[1].text = self.title.." : "..self.textBuffer.."_"
	else self.children[1].text = self.title.." : "..self.textValue
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
		if self.isActive then
			sprite:fill(
				self.pos.x+self.width-11,
				self.pos.y+6,
				5,
				5,
				self.color
			)
		end
	else

	end
end

return TextField
