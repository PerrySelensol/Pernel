local actionPanel = require("./actionPanel")
local Window = require("./elements/window")
for _, path in next, listFiles("./widgets", true) do require(path) end

--[=============================================================================]--

function actionPanel:newWindow(title, pos, size) return Window:new(title, pos, size) end

actionPanel:initialize()

return actionPanel
