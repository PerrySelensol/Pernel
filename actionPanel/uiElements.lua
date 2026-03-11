--[=============================================================================]--

local UI_Elements = {}

function UI_Elements:new(element)
	element = element or {}
	setmetatable(element, self)
	self.__index = self

	return element
end

function UI_Elements:addElement(element)
	element.parent = self
	table.insert(self.children, element)
	return element
end

return UI_Elements