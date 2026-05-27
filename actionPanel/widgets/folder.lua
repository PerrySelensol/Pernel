local actionPanel = require("../actionPanel")
local Window = require("../elements/window")

require("./button")

--[=============================================================================]--

local function folderTheme(self, sprite, activeElement)
	local selected = activeElement == self
	local accent = selected and vec(20,20,20,192)/255 or vec(0,0,0,192)/255

	sprite:fill(
		self.pos.x,
		self.pos.y,
		self.width,
		self.height,
		accent
	)
	sprite:fill(
		self.pos.x,
		self.pos.y,
		1,
		self.height,
		self.color
	)
end

function Window:newFolder(title, color)
	local window = self:new(title, self.winPos, self.winSize)
	window.parentDirectory = self

	local action = self:newAction(title)
	if color then action:setColor(color) end
	action.theme = folderTheme
	action.leftClick = function() actionPanel:setWindow(window) end
	return window
end
