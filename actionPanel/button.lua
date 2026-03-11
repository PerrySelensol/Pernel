local Box = require("./box")
local Text = require("./text")
local themes = require("./themes")

--[=============================================================================]--

local Button = Box:new()

function Button:new()

	local button = {
		name = "button",
		type = "fixed_and_center",
		direction = "vertical",
		width = width,
		height = height,
		padding = {top = 5, left = 5, bottom = 5, right = 5},
		color = vec(0,0,0)
	}
	setmetatable(button, self)
	self.__index = self

	return button

end

function Button:clickAction(button, action, modifier)
	if action = 1 then
		if self.leftClick then self.leftClick() end
		if self.rightClick then self.rightClick() end
	end
end

return Button