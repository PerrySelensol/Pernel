local UI_Elements = require("./uiElements")

--[=============================================================================]--

local Box = UI_Elements:newSubclass{
	name = "box",

	width = 0,
	height = 0,

	offset = vec(0,0),
	direction = "free",

	padding = {top = 0, left = 0, bottom = 0, right = 0},
	childgap = 0
}

do
	local new = Box.new
	function Box:new(o)
		o = new(self, o)
		o.pos = vec(0,0)
		o.children = {}
		o.color = o.color or vec(math.random(),math.random(),math.random())
		return o
	end
end

function Box:theme(sprite, activeElement)
	sprite:fill(
		self.pos.x,
		self.pos.y,
		self.width,
		self.height,
		self.color
	)
	sprite:fill(
		self.pos.x+1,
		self.pos.y+1,
		self.width-2,
		self.height-2,
		(activeElement==self) and vec(1,1,1,0.5) or vec(0,0,0,0.5)
	)
end

local function limitedIter(table, i)
	i = i+1
	local v = table[i]
	if v and ((not table.indexMax) or (i <= table.indexMax)) then
		return i, v
	end
end

function Box:render(...)
	self:theme(...)
	for _, child in limitedIter, self.children, self.children.indexMin or 0 do
		child:render(...)
	end
end

function Box:receiveCursorPos(cursorPos)

	local highlight, click, scroll =
		self,
		(self.clickAction or self.dragAction) and self,
		self.scrollAction and self
	
	if
		(cursorPos.x < self.pos.x or cursorPos.x > self.pos.x + self.width) or
		(cursorPos.y < self.pos.y or cursorPos.y > self.pos.y + self.height)
	then
		highlight, click, scroll = nil, nil, nil
	end

	for _, child in limitedIter, self.children, self.children.indexMin or 0 do
		h, c, s = child:receiveCursorPos(cursorPos)
		highlight, click, scroll = h or highlight, c or click, s or scroll
	end

	return highlight, click, scroll
end

function Box:fitWidth(parent)

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
end

function Box:fitHeight(parent)

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
end

function Box:calculatePosition(parent, givenOffset)

	self.pos = self.offset + ((parent and parent.pos) or vec(0,0)) + (givenOffset or vec(0,0))

	if self.type == "fit" then
		local tilingOffset = vec(self.padding.left, self.padding.top)

		for _, child in limitedIter, self.children, self.children.indexMin or 0 do
			child:calculatePosition(self, tilingOffset)
			if self.direction == "horizontal" then
				tilingOffset = tilingOffset + vec(child.width + self.childgap, 0)
			elseif self.direction == "vertical" then
				tilingOffset = tilingOffset + vec(0, child.height + self.childgap)
			else
				tilingOffset = tilingOffset + self.offset
			end
		end
	elseif self.type == "fixed_and_center" then
		local tilingOffset = vec(self.padding.left, self.padding.top)
		local childrenSize = vec(0,0)

		if self.direction == "vertical" then
			local self_width = self.width-self.padding.left-self.padding.right
			local self_height = self.height-self.padding.top-self.padding.bottom

			for i, child in limitedIter, self.children, self.children.indexMin or 0 do
				childrenSize.x = math.max(childrenSize.x, child.width)
				childrenSize.y = childrenSize.y + child.height + (i < (self.children.indexMax or #self.children) and self.childgap or 0)
			end

			tilingOffset.y = math.round((self_height-childrenSize.y)/2)

			for _, child in limitedIter, self.children, self.children.indexMin or 0 do
				tilingOffset.x = math.round((self_width-child.width)/2)
				child:calculatePosition(self, tilingOffset)
				tilingOffset.y = tilingOffset.y + child.height + self.childgap
			end
		else
		end
		
	else
		for _, child in limitedIter, self.children, self.children.indexMin or 0 do
			child:calculatePosition(self)
		end
	end

end

return Box
