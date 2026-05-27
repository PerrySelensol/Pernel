local actionPanel = require("actionPanel/init")

--[=============================================================================]--

Window1 = actionPanel:newWindow("", vec(120,50), vec(240,168))
actionPanel:setWindow(Window1)

--[[
	for i = 1, 47 do
		local t = math.random()
		if t < 0.3 then
			local action = Window1:newAction("Button "..i)
			action.leftClick = function() host:setActionbar("Clicked button "..i) end
		elseif t < 0.6 then
			local action = Window1:newAction("Toggle "..i)
			action.toggle = function(state)
				host:setActionbar("Toggle "..i.." set to "..(state and "true" or "false"))
			end
		else
			local win = Window1:newFolder("Folder "..i)
			for i = 1, 3 do
				local t = math.random()
				if t < 0.3 then
					local action = win:newAction("Button "..i)
					action.leftClick = function() host:setActionbar("Clicked button "..i) end
				elseif t < 0.6 then
					local action = win:newAction("Toggle "..i)
					action.toggle = function(state)
						host:setActionbar("Toggle "..i.." set to "..(state and "true" or "false"))
					end
				else
					local win = win:newFolder("Folder "..i)
				end
			end
		end
	end
--]]
--[[
	function events.mouse_press(button, action, modifer)
		--drint(button, action, modifer)
	end

	function events.render()
		trint(1, storage)
	end
--]]

local action = Window1:newAction("Button")
action.leftClick = function() host:setActionbar("Clicked button") end

local toggle = Window1:newAction("Toggle")
toggle.toggle = function(state) host:setActionbar("Toggle set to "..(state and "true" or "false")) end

local string1 = "some string"
local textfield1 = Window1:newTextField(
	"Text Field",
	function(x) string1 = x end,
	function() return string1 end
)

local num1 = 40
local textfield2 = Window1:newTextField(
	"Number",
	function(x) num1 = x end,
	function() return tonumber(num1) end
)
function textfield2.dataMap(text) return assert(tonumber(text)) end

local fac = 1.2
local slider1 = Window1:newSlider(
	"Factor", 1, 2,
	function(x) fac = tonumber(x) end,
	function() return fac end
)

local bumpscocity = 90
local slider2 = Window1:newSlider(
	"Bumpscocity", nil, nil,
	function(x) bumpscocity = tonumber(x) end,
	function() return bumpscocity end
)
