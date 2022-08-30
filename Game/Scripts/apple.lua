return function()
	local Apple = {
		grid = nil,
		baseColor = {
			r = 236,
			g = 0,
			b = 140,
			a = 255
		},
		pointX = 0,
		pointY = 0
	}

	function Apple:Load(grid)
		self.grid = grid
	end

	function Apple:Draw()
		love.graphics.setColor(self:GetBaseColor())
		local type, x, y, w, h = love.graphics.rectangle(
			"fill", 
			(self.pointX*(self.grid.width/self.grid.scale)), 
			(self.pointY*(self.grid.height/self.grid.scale)), 
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

	function Apple:SetPosition(x, y)
		self.pointX = x
		self.pointY = y
	end

	return Apple
end