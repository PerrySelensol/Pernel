--require("../funnyDemo")

local actionPanel = require("actionPanel/init")

local Box = require("actionPanel/box")
local Text = require("actionPanel/text")

local win = actionPanel:newWindow(vec(120,36), vec(240,168))

for i = 1, 16 do
	local list = win:addElement(Box:new{
		name = "box"..i,
		type = "fixed",
		width = win.width-3, --math.round(math.lerp(0,7,math.random()))*4,
		height = 17,
		padding = {top = 5, left = 5, bottom = 5, right = 5}
	})
	list:addElement(Text:new{
		text = i
	})
end

function events.mouse_press(button, action, modifer)
	--drint(button, action, modifer)
end

function events.render()
	
end
