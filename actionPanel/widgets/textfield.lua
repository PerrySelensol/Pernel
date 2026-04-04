local actionPanel, storage = require("../actionPanel")
local Box = require("../primitives/box")
local Text = require("../primitives/text")

--[=============================================================================]--

local TextField = Box:newSubclass{
	name = "textbox",
	type = "fixed",

	padding = {top = 5, left = 7, bottom = 5, right = 5},
}

do
	local new = TextField.new
	function TextField:new(o, set, get)
		o = new(self, o)
		o.set, o.get = set, get

		local label = o:addElement(Text:new())
		label.text = o.title.." "..(get() or "")
		return o
	end
end

function TextField:clickAction(button, modifier)
	if button == 0 then
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
	else self.children[1].text = self.title.." : "..storage[self.boundDataKey]
	end

	sprite:fill(
		self.pos.x,
		self.pos.y,
		self.width,
		self.height,
		accent
	)
end

return TextField
