--[=============================================================================]--

local themes = {}

function themes.mcWindow(self, sprite)
	local x, y, dx, dy = self.pos.x, self.pos.y, self.width, self.height

	for i = 0, 2 do for j = 0, 1 do
		sprite:fill(x+i+j, y+2-i+j, dx-2*i-1, dy-2*(2-i)-1, vec(0,0,0,1))
	end end
	sprite:fill(x+2, y+2, dx-4, dy-4, vec(198,198,198,255)/255)
	for i = 1, 2 do
		sprite:fill(x+i, y+3-i, dx-5, dy-5, vec(1,1,1,1))
		sprite:fill(x+i+2, y+5-i, dx-5, dy-5, vec(85,85,85,255)/255)
	end
	for i = 3, 4 do
		sprite:fill(x+i, y+7-i, dx-7, dy-7, vec(198,198,198,255)/255)
	end
	sprite:fill(x+7, y+7, dx-14, dy-14, vec(0,0,0,1))
end

function themes.basicBox(self, sprite)
	sprite:fill(
		self.pos.x,
		self.pos.y,
		self.width,
		self.height,
		self.color
	)
end

return themes