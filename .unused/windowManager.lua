local root = require("../elements")
local themes = require("../themes")

--[=============================================================================]--

local windowManager = {windows = {}}

local function scrollList(self, delta)
	local newMin = window.children.indexMin -clamp(delta, -1, 1)
	local newMax = window.children.indexMax -clamp(delta, -1, 1)

	if newMin >= 0 and newMax <= #self.children then
		self.scroll = self.scroll + clamp(delta, -1, 1)
	end
end

function windowManager:newWindow()
	local window = root:newElement{
		name = "window"..#self.windows,
		type = "fixed_and_center",
		direction = "horizontal",
		offset = vec(120,25),
		padding = {top = 7, left = 7, bottom = 7, right = 7},
		childgap = 5,
		width = 240, height = 180,
		theme = themes.mcWindow,
		scroll = 0,
		scrollAction = scrollList
	}
	window.children.indexMin = 0
	window.children.indexMax = 7
	return window
end

return windowManager