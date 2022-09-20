return function ()
	local Player = {
		x = 0,
		y = 0,
		pointX = 0,
		pointY = 0,
		velocity = 0,
		direction = 0,
		lastDirection = 0,
		lastPosition = {x=0,y=0},
		lastTailPosition = {x=0,y=0},
		tailSize = 0,
		tails = {},
		tailBasecolor = {
			r = 0/255,
			g = 174/255,
			b = 239/255,
			a = 255/255
		},
		headBasecolor = {
			r = 255/255,
			g = 217/255,
			b = 63/255,
			a = 255/255
		},
		grid = nil,
		wall = nil,
		apple = nil,
		timespanMovement = 0,
		size = {
			width = 32,
			height = 32
		}
	}
	
	-- Grid, wall, apple
	function Player:Load(grid, wall, apple)
		self.x = 0
		self.y = 0
		self.velocity = 2
		self.grid = grid
		self.wall = wall
		self.apple = apple
		self.size.width = (self.grid.width/self.grid.scale)
		self.size.height = (self.grid.height/self.grid.scale)
	end

	function Player:SetPositionAt(x,y)
		local newPosition = self.grid:GetPositionAt(x,y)
		self.x = newPosition.x
		self.y = newPosition.y
		self.lastPosition.x = self.pointX
		self.lastPosition.y = self.pointY
		self.pointX = x
		self.pointY = y
	end

	function Player:CheckIfIsWall(x,y)
		for _, coord in ipairs(self.wall:GetWallPositions()) do
			if x == coord.x and y == coord.y then
				return true
			end
		end
		
		return false --
	end

	function Player:CheckIfIsApple(x,y)

		if self.apple.pointX == x and self.apple.pointY == y then
			return true
		end
		return false
	end

	function Player:CheckIfIsTail(x, y)
		for _, tail in ipairs(self.tails) do
			if x == tail.x and y == tail.y then
				return true
			end
		end
		return false
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
			self:UpdateTailPosition()
		end

		if self.wall ~= nil and self:CheckIfIsWall(self.pointX, self.pointY) then
			self:Death()
		end
		
		if self:CheckIfIsTail(self.pointX, self.pointY) then
			self:Death()
		end

		if self.apple ~= nil and self:CheckIfIsApple(self.pointX, self.pointY) then
			local wallPositions
			local playerPositions
			if self.wall ~= nil then 
				wallPositions = self.wall:GetWallPositions()
			end

			self:AddTail()
			self.apple:RandomizePositioning(
				wallPositions, 
				{x=self.pointX, y=self.pointY},
				self.tails
			)
		end
	end

	function Player:UpdateTailPosition()

		if self.tailSize > 0 then
			self.lastTailPosition.x = self.tails[self.tailSize].x
			self.lastTailPosition.y = self.tails[self.tailSize].y
			
			local nextX, nextY = self.tails[1].x, self.tails[1].y
			
			self.tails[1].x = self.lastPosition.x
			self.tails[1].y = self.lastPosition.y
			for i = 2, self.tailSize, 1 do
				local cachedX, cachedY = self.tails[i].x, self.tails[i].y
				self.tails[i].x = nextX
				self.tails[i].y = nextY
				nextX, nextY = cachedX, cachedY
			end
		end


	end

	function Player:AddTail()
		self.tailSize = self.tailSize+1
		if self.tailSize == 1 then
			table.insert(self.tails, {x=self.lastPosition.x, y=self.lastPosition.y})
		else
			table.insert(self.tails, {x=self.lastTailPosition.x, y=self.lastTailPosition.y})
		end

		if self.grid ~= nil and self.tailSize >= (((self.grid.scale-2)^2)-2) then
			self:Victory()
		end
	end

	function Player:Death()
		love.window.close()
	end
	
	function Player:Victory()
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

		local drawing = {}

		love.graphics.setColor(self:GetTailColor())

		for i = self.tailSize, 1, -1 do
			local position = self.grid:GetPositionAt(self.tails[i].x,self.tails[i].y)
			table.insert(
						drawing, 
						love.graphics.rectangle(
							"fill",
							position.x,position.y,
							self.size.width,self.size.height) or nil
					)
		end

		love.graphics.setColor(self:GetHeadColor())

		table.insert(
						drawing, 
						love.graphics.rectangle(
							"fill",
							self.x,self.y,
							self.size.width,self.size.height) or nil
					)
		love.graphics.setColor(255,255,255,255)

		return drawing
	end

	function Player:GetTailColor()
		return 
			self.tailBasecolor.r,
			self.tailBasecolor.g,
			self.tailBasecolor.b,
			self.tailBasecolor.a
	end

	function Player:GetHeadColor()
		return 
			self.headBasecolor.r,
			self.headBasecolor.g,
			self.headBasecolor.b,
			self.headBasecolor.a
	end

	return Player
end