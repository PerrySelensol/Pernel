local actionPanel, storage = require("../actionPanel")
local Box = require("../primitives/box")
local Text = require("../primitives/text")

--[=============================================================================]--

local ArrayEditor = Box:newSubclass{
	name = "arrayEditor",

	width = 0,
	height = 0,

	type = "fixed",

	padding = {top = 5, left = 7, bottom = 5, right = 5}
}
ArrayEditor.color = nil

do
	local new = ArrayEditor.new
	function ArrayEditor:new(o)
		o = new(self, o)
		for i = 1, #self.boundArray do
			o:addElement(Text:new())
		end
		return o
	end
end

