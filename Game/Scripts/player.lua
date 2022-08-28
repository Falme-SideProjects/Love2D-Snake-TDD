return function ()
	local Player = {
		x = 0,
		y = 0,
		pointX = 0,
		pointY = 0,
		velocity = 0,
		direction = 0,
		lastDirection = 0,
		grid = nil,
		wall = nil,
		timespanMovement = 0,
		size = {
			width = 32,
			height = 32
		}
	}
	
	function Player:Load(grid, wall)
		self.x = 0
		self.y = 0
		self.velocity = 2
		self.grid = grid
		self.wall = wall
		self.size.width = (self.grid.width/self.grid.scale)
		self.size.height = (self.grid.height/self.grid.scale)
	end

	function Player:SetPositionAt(x,y)
		local newPosition = self.grid:GetPositionAt(x,y)
		self.x = newPosition.x
		self.y = newPosition.y
		self.pointX = x
		self.pointY = y
	end

	function Player:CheckIfIsWall(x,y)
		for _, coord in ipairs(self.wall:GetWallPositions()) do
			if self.grid:GetPositionAt(x,y).x == coord.x and
				self.grid:GetPositionAt(x,y).y == coord.y then
					return true
			end
		end
		
		return false --
	end
	
	function Player:Update(dt)
		self.timespanMovement = self.timespanMovement+(dt * self.velocity)
		
		if self.timespanMovement >= 1 then
			self.timespanMovement = self.timespanMovement-1;
			if self.direction == 0 then
				self:SetPositionAt(self.pointX+1, self.pointY)
			elseif self.direction == 1 then
				self:SetPositionAt(self.pointX, self.pointY+1)
			elseif self.direction == 2 then
				self:SetPositionAt(self.pointX-1, self.pointY)
			else
				self:SetPositionAt(self.pointX, self.pointY-1)
			end

			self.lastDirection = self.direction
		end

		if self:CheckIfIsWall(self.pointX, self.pointY) then
			self:Death()
		end
	end

	function Player:Death()
		love.window.close()
	end

	function Player:KeyPressed(key)
		if key == "right" and self.lastDirection ~= 2 then self.direction = 0
		elseif key == "down" and self.lastDirection ~= 3 then self.direction = 1
		elseif key == "left" and self.lastDirection ~= 0 then self.direction = 2
		elseif key == "up" and self.lastDirection ~= 1 then self.direction = 3
		end
	end
	
	function Player:Draw()
		return love.graphics.rectangle(
			"fill",
			self.x,self.y,
			self.size.width,self.size.height)
	end

	return Player
end