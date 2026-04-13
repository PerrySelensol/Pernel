local actionPanel = require("../actionPanel")
local Box = require("../primitives/box")
local Text = require("../primitives/text")

--[=============================================================================]--

local LinkedToggle = Box:newSubclass{
	name = "linked_toggle",
	type = "fixed",

	padding = {top = 5, left = 7, bottom = 5, right = 5},
}

do
	local new = LinkedToggle.new
	function LinkedToggle:new(o, set, get)
		o = new(self, o)
		o.set, o.get = set, get

		local label = o:addElement(Text:new())
		label.text = o.title
		return o
	end
end

function LinkedToggle:clickAction(button, modifier)
	if button == 0 then
		self.set(not self.get())
	end
end

function LinkedToggle:theme(sprite, activeElement, activeTextField)
	local accent = vec(0,0,0,192)/255
	local selected = activeElement == self
	local active = self.get()
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
end

return LinkedToggle
