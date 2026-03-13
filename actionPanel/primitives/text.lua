local UI_Elements = require("./uiElements")
local hudPart, sprite, Text_Tasks = require("./uiTasks")

--[=============================================================================]--

local Text = UI_Elements:new{
	name = "text",

	width = 0,
	height = 0,

	children = {}
}

do
	local new = Text.new
	function Text:new(o)
		o = new(self, o)
		o.pos = vec(0,0)
		return o
	end
end

function Text:render(sprite, activeElement)

	Text_Tasks[Text_Tasks.index]:text(self.text):pos(-self.pos.xy_):setVisible(true)
	Text_Tasks.index = Text_Tasks.index + 1

end

function Text:receiveCursorPos(cursorPos) end

function Text:fitWidth(parent)
--[[
	if self.type == "fit" then self.width = 0 end

	for _, child in limitedIter, self.children, self.children.indexMin or 0 do
		child:fitWidth(self)
	end

	if self.type == "fit" then
		self.width = self.width + self.padding.left + self.padding.right
		- ((self.direction == "horizontal" and self.children[(self.children.indexMin or 0)+1]) and self.childgap or 0)
		if self.minWidth then self.width = math.max(self.minWidth, self.width) end
	end

	if parent and parent.type == "fit" then
		if parent.direction == "horizontal" then
			parent.width = parent.width + self.width + parent.childgap
		elseif parent.direction == "vertical" then
			parent.width = math.max(parent.width, self.width)
		elseif parent.direction == "free" then
			parent.width = math.max(parent.width, self.offset.x + self.width)
		end
	end
--]]
end

function Text:fitHeight(parent)
--[[
	if self.type == "fit" then self.height = 0 end

	for _, child in limitedIter, self.children, self.children.indexMin or 0 do
		child:fitHeight(self)
	end

	if self.type == "fit" then
		self.height = self.height + self.padding.top + self.padding.bottom
		- ((self.direction == "vertical" and self.children[(self.children.indexMin or 0)+1]) and self.childgap or 0)
		if self.minHeight then self.height = math.max(self.minHeight, self.height) end
	end

	if parent and parent.type == "fit" then
		if parent.direction == "vertical" then
			parent.height = parent.height + self.height + parent.childgap
		elseif parent.direction == "horizontal" then
			parent.height = math.max(parent.height, self.height)
		elseif parent.direction == "free" then
			parent.height = math.max(parent.height, self.offset.y + self.height)
		end
	end
--]]
end

function Text:calculatePosition(parent, givenOffset)
	self.pos = ((parent and parent.pos) or vec(0,0)) + vec(parent.padding.left, parent.padding.top)
end

return Text