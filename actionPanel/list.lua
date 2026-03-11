local Box = require("./box")
local Text = require("./text")
local themes = require("./themes")

--[=============================================================================]--

local List = Box:new()

function List:new(width, height, listSize)

	local list = {
		name = "list",
		type = "fixed_and_center",
		direction = "vertical",
		width = width,
		height = height,
		children = {indexMin = 0, indexMax = listSize},
		padding = {top = 0, left = 0, bottom = 0, right = 4},
		color = vec(0,0,0)
	}
	setmetatable(list, self)
	self.__index = self

	return list
end

function List:theme(sprite)
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
	--sprite:fill(
	--	self.pos.x,
	--	self.pos.y,
	--	self.width,
	--	self.height,
	--	vec(1,1,1)
	--)

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