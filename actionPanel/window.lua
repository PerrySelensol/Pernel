local Box = require("./box")
local List = require("./list")
local Text = require("./text")
local Button = require("./button")
local Themes = require("./themes")

--[=============================================================================]--

local Window = {}

function Window:new(pos, size)

	local o = {elements = {}}
	setmetatable(o, self)
	self.__index = self

	local offset = pos or vec(120,28)
	local width, height = (size and size.x) or 240, (size and size.y) or 180

	o.elements.frame = Box:new{
		name = "frame",
		offset = offset,
		type = "fixed",
		width = width,
		height = height,
		padding = {top = 7, left = 7, bottom = 7, right = 7},
		theme = Themes.mcWindow
	}

	o.elements.breadCrumbs = o.elements.frame:addElement(Box:new{
		name = "breadCrumbs",
		type = "fixed_and_center",
		direction = "vertical",
		offset = vec(8,8),
		width = width-16,
		height = 15,
		color = vec(0.2,0.2,0.2,1),
		padding = {top = 4, left = 4, bottom = 4, right = 4},
		theme = Themes.basicBox
	})

	o.elements.breadCrumbs:addElement(Text:new{
		text = "/ home > walls > door"
	})

	o.elements.listPart = o.elements.frame:addElement(List:new(width-16, height-32, 8))
	o.elements.listPart.offset = vec(8, 24)

	return o
end

function Window:newAction(title)
	local action = self.elements.listPart:addElement(Button:new{
		width = self.elements.listPart.width-3,
		height = 17
	})
	action.children[1].text = title or "Action"
	return action
end

function Window:render(sprite, activeElement)
	self.elements.frame:render(sprite, activeElement)
end

return Window