local hudPart, sprite, Text_Tasks = require("./primitives/uiTasks")

--[=============================================================================]--

local activeWindow
local activeTextField
local actionPanel = {}
local storage = {}

function actionPanel:setWindow(win) activeWindow = win end
function actionPanel:setTextField(field) activeTextField = field end

-- ============ Register Events ============ --

function actionPanel:initialize()
	if not host:isHost() then return end

	local highlightElement, clickElement, scrollElement
	local preDragValue
	local mouseState = "hovering"

	do
		local button, action, modifier = 0,0,0
		local clickedPos = vec(0,0)

		function events.mouse_press(b, a, m)
			if not hudPart:getVisible() then return end

			button, action, modifier = b, a, m

			if action == 0 then
				if mouseState == "hovering" and clickElement and clickElement.clickAction then
					clickElement:clickAction(button, modifier)
				end
				mouseState = "hovering"
			else
				clickedPos = client.getMousePos()
				if clickElement and clickElement.dragAction then
					preDragValue = storage[clickElement.boundDataKey]
				end
			end
		end

		function events.mouse_move(dx, dy)
			if not hudPart:getVisible() then return end

			if action == 1 then
				local dragDist = (client.getMousePos()-clickedPos)/client.getGuiScale()

				if dragDist:lengthSquared() > 1 then
					mouseState = "dragging"
				end

				if mouseState == "dragging" and clickElement and clickElement.dragAction then
					clickElement:dragAction(preDragValue, dragDist)
				end
			end

		end

		function events.mouse_scroll(delta)
			if not hudPart:getVisible() then return end
			if scrollElement and scrollElement.scrollAction then
				scrollElement:scrollAction(delta)
			end
			return true
		end

	end

	function events.tick()
		if not hudPart:getVisible() then return end

		local guiScale = client.getGuiScale()
		local winSize = client.getWindowSize()
		local hudShift = (vec(1920,1080)-winSize*4/guiScale)/8
		local mousePos = client.getMousePos()/guiScale + hudShift
		hudPart:setPos(hudShift.xy_)

		sprite:fill(0,0, 1920/4, 1080/4, vec(0,0,0,0))
		for i = 1, #Text_Tasks do Text_Tasks[i]:setVisible(false) end
		Text_Tasks.index = 1

		local activeWinUI = activeWindow.elements.frame

		activeWinUI:fitWidth()
		activeWinUI:fitHeight()
		activeWinUI:calculatePosition()

		if mouseState == "hovering" then
			highlightElement, clickElement, scrollElement = activeWinUI:receiveCursorPos(mousePos)
		end

		activeWinUI:render(sprite, highlightElement, activeTextField)
		sprite:update()

		--drint(
		--	highlightElement and highlightElement.name,
		--	clickElement and clickElement.name,
		--	scrollElement and scrollElement.name
		--)
	end

	function events.char_typed(char, modifier, codepoint)
		if not (hudPart:getVisible() and activeTextField) then return end
		activeTextField.textBuffer = activeTextField.textBuffer..char
	end

	function events.key_press(key, action, modifer)
		if not (hudPart:getVisible() and action >= 1) then return end

		if key == 256 then -- Esc

			if activeTextField then
				activeTextField.textBuffer = ""
				activeTextField = nil
			else
				hudPart:setVisible(false)
				host.unlockCursor = false
				renderer.renderCrosshair = true
			end
			return true

		elseif key == 259 and activeTextField then -- Backspace

			activeTextField.textBuffer = activeTextField.textBuffer:sub(1, -2)

		elseif key == 257 and activeTextField then -- Enter

			local valid, mappedInput = true, nil
			if activeTextField.dataMap then
				valid, mappedInput = pcall(activeTextField.dataMap, activeTextField.textBuffer)
			else
				mappedInput = activeTextField.textBuffer
			end
			if not valid then
				host:setActionbar("Invalid Value!")
				return true
			end
			storage[activeTextField.boundDataKey] = mappedInput
			activeTextField.textBuffer = ""
			activeTextField = nil

		elseif activeTextField then

			return true

		end

	end

end

-- ============ Keybinds ============ --

local activatePanel = keybinds:fromVanilla("figura.config.action_wheel_button")

local F3 = keybinds:newKeybind("F3", "key.keyboard.f3")

activatePanel.press = function() if not F3:isPressed() then
	hudPart:setVisible(not hudPart:getVisible())
	host.unlockCursor = not host:isCursorUnlocked()
	renderer.renderCrosshair = not renderer:shouldRenderCrosshair()
	return true
end end

local keyUp = keybinds:newKeybind("Go up a Folder", "key.mouse.4")
keyUp.press = function()
	if hudPart:getVisible() and activeWindow.parentDirectory then
		if activeTextField then
			activeTextField.textBuffer = ""
			activeTextField = nil
		end
		actionPanel:setWindow(activeWindow.parentDirectory)
	end
end

return actionPanel, storage
