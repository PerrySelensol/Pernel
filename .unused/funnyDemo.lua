local root = require("../elements")
local themes = require("../themes")

local box1 = root:newElement{
	name = "box1",
	type = "fixed",
	offset = vec(40,140),
	padding = {top = 15, left = 15, bottom = 15, right = 15},
	childgap = 5,
	width = 20, height = 20,
}

local box2 = root:newElement{
	name = "box2",
	type = "fit",
	direction = "horizontal",
	offset = vec(50,50),
	padding = {top = 7, left = 7, bottom = 7, right = 7},
	childgap = 5,
	width = 100, height = 100,
	theme = themes.mcWindow
}

	local box21 = box2:newElement{
		name = "box21",
		type = "fixed",
		width = 20, height = 90,
	}

	local box22 = box2:newElement{
		name = "box22",
		type = "fixed_and_center",
		direction = "vertical",
		childgap = 5,
		width = 70, height = 150,
		padding = {top = 7, left = 7, bottom = 7, right = 7},
		theme = themes.mcWindow
	}

		local box221 = box22:newElement{
			name = "box221",
			type = "fixed",
			width = 40, height = 10,
		}

		local box222 = box22:newElement{
			name = "box222",
			type = "fixed",
			width = 30, height = 10,
		}

		local box223 = box22:newElement{
			name = "box223",
			type = "fixed",
			width = 20, height = 10,
		}

	local box23 = box2:newElement{
		name = "box23",
		type = "fixed",
		width = 50, height = 70,
	}

		local box231 = box23:newElement{
			name = "box231",
			type = "fixed",
			offset = vec(40,60),
			width = 20, height = 20,
		}

	local box24 = box2:newElement{
		name = "box24",
		type = "fit",
		direction = "free",
		width = 50, height = 70,
		padding = {top = 5, left = 5, bottom = 5, right = 5}
	}

		local box241 = box24:newElement{
			name = "box241",
			type = "fixed",
			offset = vec(70,30),
			width = 40, height = 20,
			clickAction = function(self, button, action, modifier)
				if button == 0 and action == 1 then host:setActionbar("Button Pressed!") end
			end
		}

		local box242 = box24:newElement{
			name = "box242",
			type = "fixed",
			offset = vec(0,20),
			width = 20, height = 40,
			dragAction = function(self, delta)
				self.offset = self.offset + delta
				self.offset.x = math.clamp(self.offset.x, 0, 100)
				self.offset.y = math.clamp(self.offset.y, 0, 100)
			end
		}


local function t(s, x) return math.sin(s*world:getTime()/48 +x)^2 end

function events.tick() do return end
	box1.offset.x = math.round(t(1,0)*170+20)
	box1.offset.y = math.round(t(4,2)*20+20)

	--box2.offset.x = math.round(t(1,0)*80+50)
	--box2.offset.y = math.round(t(1,2)*20+50)
		box21.height = math.round(t(1,1)*100+20)
		--box22.width = math.round(t(1,2)*120+20)
			--box221.height = math.round(t(1,3)*60+20)
			--box222.width = math.round(t(4,0)*60+20)
			--box223.width = math.round(t(4,1)*40+20)

		box23.width = math.round(t(1,2)*20+40)

			box241.offset.x = math.round(t(3,0)*40)
			box241.offset.y = math.round(t(3,1)*40)

			box242.offset.x = math.round(t(5,0)*40+20)
			box242.offset.y = math.round(t(5,1)*40+10)
end
