local actionPanel = require("../actionPanel")
local Box = require("../primitives/box")
local List = require("../elements/list")
local Text = require("../primitives/text")
local Button = require("../widgets/button")
local LinkedToggle = require("../widgets/linkedToggle")
local TextField = require("../widgets/textfield")
local Slider = require("../widgets/slider")
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

function Window:newAction(title)
	local action = self.elements.listPart:addElement(Button:new{
		width = self.elements.listPart.width-3,
		height = 17
	})
	action.children[1].text = title
	return action
end

function Window:newLinkedToggle(title, set, get)
	local toggle = self.elements.listPart:addElement(LinkedToggle:new({
		width = self.elements.listPart.width-3,
		height = 17,

		title = title,
	}, set, get))
	
	return toggle
end

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

function Window:newTextField(title, set, get)
	local field = self.elements.listPart:addElement(TextField:new({
		width = self.elements.listPart.width-3,
		height = 17,

		title = title,
		textBuffer = ""
	}, set, get))
	
	return field
end

function Window:newSlider(title, min, max, set, get)
	local slider = self.elements.listPart:addElement(Slider:new({
		width = self.elements.listPart.width-3,
		height = 17,

		title = title,
		textBuffer = "",
		sliderMin = min,
		sliderMax = max
	}, set, get))
	
	return slider
end

function Window:render(sprite, activeElement)
	self.elements.frame:render(sprite, activeElement)
end

return Window