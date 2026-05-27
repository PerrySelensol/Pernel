local actionPanel = require("../actionPanel")
local Box = require("../primitives/box")
local List = require("../elements/list")
local Text = require("../primitives/text")
local Themes = require("../elements/themes")

--[=============================================================================]--

local Window = {}

function Window:new(title, pos, size)

	local o = {elements = {}}
	setmetatable(o, self)
	self.__index = self

	local offset = pos or vec(120, 50)
	local width, height = (size and size.x) or 240, (size and size.y) or 168

	self.winPos, self.winSize = offset, vec(width,height)

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
		text = "> "..(title or "")
	})

	o.elements.listPart = o.elements.frame:addElement(List:new(width-16, height-32, 8))
	o.elements.listPart.offset = vec(8, 24)

	return o
end

function Window:render(sprite, activeElement)
	self.elements.frame:render(sprite, activeElement)
end

return Window