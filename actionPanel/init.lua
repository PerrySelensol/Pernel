local actionPanel = require("./actionPanel")
local Window = require("./elements/window")

--[=============================================================================]--

function actionPanel:newWindow(title, pos, size) return Window:new(title, pos, size) end

actionPanel:initialize()

return actionPanel
