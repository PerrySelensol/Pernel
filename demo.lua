local actionPanel = require("actionPanel/init")

--[=============================================================================]--

Window1 = actionPanel:newWindow("", vec(120,50), vec(240,168))
actionPanel:setWindow(Window1)

-- Action button and toggle; mimics figura's action wheel action
local action = Window1:newAction("Button")
action.leftClick = function() host:setActionbar("Clicked button") end

local toggle = Window1:newAction("Toggle")
toggle.toggle = function(state) host:setActionbar("Toggle set to "..(state and "true" or "false")) end

-- Folder
local folder1 = Window1:newFolder("Folder", vec(0,1,1))
	local action_in_folder = folder1:newAction("Button in Folder")
	action_in_folder.leftClick = function() host:setActionbar("Clicked button inside folder") end

-- Textfield
local string1 = "some string"
local textfield1 = Window1:newTextField(
	"Text Field",
	function(x) string1 = x end,
	function() return string1 end
)

-- Textfield with custom data mapping and validation
-- Accept any format of number: decimal, hex, etc. This is due to tonumber() function being used
local num1 = 40
local textfield2 = Window1:newTextField(
	"Number",
	function(x) num1 = x end,
	function() return tonumber(num1) end
)
function textfield2.dataMap(text) return assert(tonumber(text)) end

-- Number sliders: can either have limits or no limits
-- Currently not supporting one-sided limit

-- Numbers can also be inputted directly like textfield
-- Accepts various formats since it also uses tonumber()

-- With min and max value set
-- The limits are soft, so manual input outside the range is still possible
local fac = 1.2
local slider1 = Window1:newSlider(
	"Factor", 1, 2,
	function(x) fac = tonumber(x) end,
	function() return fac end
)

-- Without min and max value set
local bumpscocity = 90
local slider2 = Window1:newSlider(
	"Bumpscocity", nil, nil,
	function(x) bumpscocity = tonumber(x) end,
	function() return bumpscocity end
)

-- Color sliders: also accepts pasting hex with Shift+V
local r1, g1, b1 = 255, 255, 255
local rgb = Window1:newRGB(
	"Color",
	function(x) r1 = tonumber(x) end,
	function(x) g1 = tonumber(x) end,
	function(x) b1 = tonumber(x) end,
	function() return r1 end,
	function() return g1 end,
	function() return b1 end
)