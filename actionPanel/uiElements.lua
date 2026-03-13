--[=============================================================================]--

local UI_Elements = {}

function UI_Elements:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function UI_Elements:addElement(element)
	element.parent = self
	table.insert(self.children, element)
	return element
end

return UI_Elements