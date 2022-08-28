return function()
	local Apple = {
		grid = nil,
		baseColor = {
			r = 255,
			g = 0,
			b = 0,
			a = 255
		}
	}

	function Apple:Load(grid)
		self.grid = grid
	end

	function Apple:Draw()
		love.graphics.setColor(self:GetBaseColor())
		local type, x, y, w, h = love.graphics.rectangle(
			"fill", 
			0, 
			0, 
			(self.grid.width/self.grid.scale),
			(self.grid.height/self.grid.scale)
		)
		love.graphics.setColor(255,255,255,255)
		return type, x, y, w, h
	end

	function Apple:GetBaseColor()
		return self.baseColor.r,
				self.baseColor.g,
				self.baseColor.b,
				self.baseColor.a
	end

	return Apple
end