local actionPanel = require("actionPanel/init")

--[=============================================================================]--

Window1 = actionPanel:newWindow(vec(120,36), vec(240,168))
actionPanel:setWindow(Window1)

for i = 1, 47 do
	local action = Window1:newAction(i)
	if math.random() < 0.5 then
		action.leftClick = function() host:setActionbar("Triggered "..i) end
	else
		action.toggle = function(state) host:setActionbar("Toggle "..i.." is now "..(state and "true" or "false")) end
	end
end

function events.mouse_press(button, action, modifer)
	--drint(button, action, modifer)
end

function events.render()
	
end
