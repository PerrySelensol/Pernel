local actionPanel = require("../actionPanel")
local Window = require("../elements/window")
local Slider = require("../widgets/slider")
local Box = require("../primitives/box")

require("./button")

--[=============================================================================]--

local function rgbTheme(self, sprite, activeElement)
	local selected = activeElement == self
	local accent = selected and vec(20,20,20,192)/255 or vec(0,0,0,192)/255
	local color = vec(self.r_get(), self.g_get(), self.b_get())

	sprite:fill(
		self.pos.x,
		self.pos.y,
		self.width,
		self.height,
		accent
	)
	sprite:fill(
		self.pos.x+self.width-16,
		self.pos.y+1,
		15,
		self.height-2,
		color/255
	)

	sprite:fill(
		self.pos.x+1,
		self.pos.y+3,
		1,
		3,
		vec(0.75,0.25,0.25)
	)
	sprite:fill(
		self.pos.x+1,
		self.pos.y+7,
		1,
		3,
		vec(0.25,0.75,0.25)
	)
	sprite:fill(
		self.pos.x+1,
		self.pos.y+11,
		1,
		3,
		vec(0.25,0.25,0.75)
	)

	self.children[1].text = self.title.." : "..tostring(color)
end

local function solidColor(self, sprite, activeElement)
	sprite:fill(
		self.pos.x,
		self.pos.y,
		self.width,
		self.height,
		vec(self.r_get(), self.g_get(), self.b_get())/255
	)
end

local function pasteColor(self, clip)
	local r_, g_, b_ = string.match(clip, "(%x%x)(%x%x)(%x%x)")
	local r, g, b = tonumber("0x"..(r_ or "z")), tonumber("0x"..(g_ or "z")), tonumber("0x"..(b_ or "z"))

	if not (r and g and b) then return end

	self.r_set(r); self.g_set(g); self.b_set(b)
end

local function addPalette(self, palette)
	for _, color in ipairs(palette) do
		local a = self.linkedAction
		self:newAction(
				'[{"text":"█:back1:█:back1:█:back1:█:back1:█:back1:█", "color":"#'
				..vectors.rgbToHex(color/255)..
				'"}]'
			)
			:setColor(color/255)
			:onLeftClick(function() a.r_set(color.x); a.g_set(color.y); a.b_set(color.z) end)
	end
	return self
end

function Window:newRGB(title, r_set, g_set, b_set, r_get, g_get, b_get)
	local window = self:new(title, self.winPos, self.winSize)
	window.parentDirectory = self

	local action = self:newAction(title)
	action.title = title
	action.theme = rgbTheme
	action.pasteAction = pasteColor
	action.r_set, action.g_set, action.b_set = r_set, g_set, b_set
	action.r_get, action.g_get, action.b_get = r_get, g_get, b_get
	action.leftClick = function() actionPanel:setWindow(window) end

	local preview = window:newAction("")
	preview.theme = solidColor
	preview.pasteAction = pasteColor
	preview.r_set, preview.g_set, preview.b_set = r_set, g_set, b_set
	preview.r_get, preview.g_get, preview.b_get = r_get, g_get, b_get

	window.linkedAction = action
	window:newSlider("Red",   0, 255, r_set, r_get):setColor(vec(1,0,0)):setStep(1)
	window:newSlider("Green", 0, 255, g_set, g_get):setColor(vec(0,1,0)):setStep(1)
	window:newSlider("Blue",  0, 255, b_set, b_get):setColor(vec(0,0,1)):setStep(1)

	window.addPalette = addPalette

	return window
end
