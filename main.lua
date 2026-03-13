local actionPanel = require("actionPanel/init")

--[=============================================================================]--

Window1 = actionPanel:newWindow("", vec(120,50), vec(240,168))
actionPanel:setWindow(Window1)

for i = 1, 47 do
	local t = math.random()
	if t < 0.3 then
		local action = Window1:newAction("Button "..i)
		action.leftClick = function() host:setActionbar("Clicked button "..i) end
	elseif t < 0.6 then
		local action = Window1:newAction("Toggle "..i)
		action.toggle = function(state) host:setActionbar("Toggle "..i.." set to "..(state and "true" or "false")) end
	else
		local win = Window1:newFolder("Folder "..i)
		for i = 1, 3 do
			local t = math.random()
			if t < 0.3 then
				local action = win:newAction("Button "..i)
				action.leftClick = function() host:setActionbar("Clicked button "..i) end
			elseif t < 0.6 then
				local action = win:newAction("Toggle "..i)
				action.toggle = function(state) host:setActionbar("Toggle "..i.." set to "..(state and "true" or "false")) end
			else
				local win = win:newFolder("Folder "..i)
			end
		end
	end
end

function events.mouse_press(button, action, modifer)
	--drint(button, action, modifer)
end

function events.render()
	
end
