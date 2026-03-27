local actionPanel, storage = require("../actionPanel")
local TextField = require("../widgets/textfield")
local Box = require("../primitives/box")
local Text = require("../primitives/text")

--[=============================================================================]--

local Slider = TextField:new{
	name = "slider",

	width = 0,
	height = 0,

	type = "fixed",

	padding = {top = 5, left = 7, bottom = 5, right = 5},

	dataMap = function(n) return assert(tonumber(n)) end
}
Slider.color = nil

if false then
	local new = Slider.new
	function Slider:new(o)
		o = new(self, o)
		o:addElement(Text:new())
		o.isActive = false
		return o
	end
end

function Slider:dragAction(delta)
	storage[self.boundDataKey] = storage[self.boundDataKey] + delta.x
end

return Slider