local Box = require("../primitives/box")
local Text = require("../primitives/text")

--[=============================================================================]--

local Slider = Box:new{
	name = "slider",

	width = 0,
	height = 0,

	type = "fixed",

	padding = {top = 5, left = 7, bottom = 5, right = 5}
}
Slider.color = nil

do
	local new = Slider.new
	function Slider:new(o)
		o = new(self, o)
		o:addElement(Text:new())
		o.isActive = false
		return o
	end
end

function Slider:dragAction(delta)
	
end