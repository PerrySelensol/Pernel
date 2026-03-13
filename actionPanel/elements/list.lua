local Box = require("../primitives/box")

--[=============================================================================]--

local List = Box:new{
	name = "list",

	type = "fixed_and_center",
	direction = "vertical",

	padding = {top = 0, left = 0, bottom = 0, right = 4},

	color = vec(0,0,0)
}

do
	local new = List.new
	function List:new(width, height, listSize)
		local o = new(self, {
			width = width,
			height = height
		})
		o.children.indexMin = 0
		o.children.indexMax = listSize
		return o
	end
end

function List:theme(sprite, activeElement)
	local totalCount = math.max(1,#self.children)
	local visibleCount = math.max(1,self.children.indexMax-self.children.indexMin)
	local barPos = math.floor(self.children.indexMin*self.height/totalCount)
	local barHeight = math.min(self.height, math.ceil(self.height*visibleCount/totalCount))
	sprite:fill(
		self.pos.x,
		self.pos.y,
		self.width,
		self.height,
		self.color
	)
	sprite:fill(
		self.pos.x+self.width-2,
		self.pos.y+barPos,
		2,
		barHeight,
		vec(1,1,1)
	)
end

function List:scrollAction(delta)
	delta = math.clamp(delta, -1, 1)
	local newMin = self.children.indexMin -delta
	local newMax = self.children.indexMax -delta

	if newMin >= 0 and newMax <= #self.children then
		self.children.indexMin = newMin
		self.children.indexMax = newMax
	end
end

return List