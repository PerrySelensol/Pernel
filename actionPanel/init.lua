local Box = require("./box")
local Window = require("actionPanel/window")
local hudPart, sprite, Text_Tasks = require("./uiTasks")

--[=============================================================================]--

local activeWindow
local actionPanel = {}

function actionPanel:newWindow(pos, size)
	return Window:new(pos, size)
end
function actionPanel:setWindow(win) activeWindow = win end

-- ============ Register Events ============ --

if host:isHost() then

	local highlightElement, clickElement, scrollElement
	local mouseState = 0

	do
		local button, action, modifier = 0,0,0
		local moveAccum = vec(0,0)

		function events.mouse_press(b, a, m)
			if not hudPart:getVisible() then return end

			button, action, modifier = b, a, m

			if action == 1 then
				clickedPos = client.getMousePos()
			else
				mouseState = 0
				moveAccum:reset()
			end

			if clickElement and clickElement.clickAction then
				clickElement:clickAction(button, action, modifier)
			end

		end

		function events.mouse_move(dx, dy)
			if not hudPart:getVisible() then return end

			if action == 1 then
				local s = 1/client.getGuiScale()
				moveAccum:add(dx*s,dy*s)

				if moveAccum:lengthSquared() > 1 then
					mouseState = 1
					if clickElement and clickElement.dragAction then
						clickElement:dragAction(vec(dx*s,dy*s))
					end
				end
			end

		end

		function events.mouse_scroll(delta)
			if not hudPart:getVisible() then return end
			if scrollElement and scrollElement.scrollAction then
				scrollElement:scrollAction(delta)
				return true
			end
		end

	end

	function events.tick()
		if not hudPart:getVisible() then return end
		sprite:fill(0,0, 1920/4, 1080/4, vec(0,0,0,0))
		for i = 1, #Text_Tasks do Text_Tasks[i]:setVisible(false) end
		Text_Tasks.index = 1

		local activeWinUI = activeWindow.elements.frame

		activeWinUI:fitWidth()
		activeWinUI:fitHeight()
		activeWinUI:calculatePosition()

		if mouseState == 0 then
			local mousePos = client.getMousePos()/client.getGuiScale()
			highlightElement, clickElement, scrollElement = activeWinUI:receiveCursorPos(mousePos)
		end

		activeWinUI:render(sprite, highlightElement)
		sprite:update()

		--drint(
		--	highlightElement and highlightElement.name,
		--	clickElement and clickElement.name,
		--	scrollElement and scrollElement.name
		--)
	end

	function events.char_typed(char, modifier, codepoint)
		if not (hudPart:getVisible() and Active_Prompt) then return end
		Active_Prompt.current_string = Active_Prompt.current_string..char
	end

	function events.key_press(key, action, modifer)
		if not (hudPart:getVisible() and action >= 1) then return end

		if key == 256 then -- Esc

			if Active_Prompt then
				Active_Prompt.current_string = ""
				Active_Prompt = nil
			else
				hudPart:setVisible(false)
				host.unlockCursor = false
				renderer.renderCrosshair = true
			end
			return true

		elseif key == 259 and Active_Prompt then -- Backspace

			Active_Prompt.current_string = Active_Prompt.current_string:sub(1, -2)

		elseif key == 257 and Active_Prompt and Active_Prompt.toValue then -- Enter

			local valid, converted = pcall(Active_Prompt.toValue, Active_Prompt.current_string)
			if valid then
				Active_Prompt.table[Active_Prompt.key] = converted
				if Active_Prompt.argsHandler then Active_Prompt.argsHandler(Active_Prompt.current_string) end
			else
				host:setActionbar("Invalid Value!")
			end
			Active_Prompt.current_string = ""
			Active_Prompt = nil

		elseif Active_Prompt then

			return true

		end

	end


end

-- ============ Keybinds ============ --

local activePanel = keybinds:fromVanilla("figura.config.action_wheel_button")

local F3 = keybinds:newKeybind("F3", "key.keyboard.f3")

activePanel.press = function() if not F3:isPressed() then
	hudPart:setVisible(not hudPart:getVisible())
	host.unlockCursor = not host:isCursorUnlocked()
	renderer.renderCrosshair = not renderer:shouldRenderCrosshair()
	return true
end end

--local KeyUp = keybinds:newKeybind("Folder Up", "key.mouse.4")
--KeyUp.press = function() if hudPart:getVisible() and Active_Window.parent then
--
--	scrollDist = 0; Active_Window.parent:render()
--
--end end


return actionPanel
