local Box = require("./box")
local List = require("./list")
local Text = require("./text")
local themes = require("./themes")

--[=============================================================================]--

local Window = Box:new()
local scrollAction

function Window:new(pos, size)

	local offset = pos or vec(120,28)
	local width, height = (size and size.x) or 240, (size and size.y) or 180

	local win = self:addElement(Box:new{
		name = "window",
		offset = offset,
		type = "fixed",
		width = width,
		height = height,
		padding = {top = 7, left = 7, bottom = 7, right = 7},
		theme = themes.mcWindow
	})

	local breadCrumbs = win:addElement(Box:new{
		name = "breadCrumbs",
		type = "fixed_and_center",
		direction = "vertical",
		offset = vec(8,8),
		width = width-16,
		height = 15,
		color = vec(0.2,0.2,0.2,1),
		padding = {top = 4, left = 4, bottom = 4, right = 4},
		theme = themes.basicBox
	})

	local crumbs = breadCrumbs:addElement(Text:new{
		text = "/ home > walls > door"
	})

	local listPart = win:addElement(List:new(width-16, height-32, 8))
	listPart.offset = vec(8, 24)

	return listPart
end

return Window