return function ()
	local Player = {
		x = 0,
		y = 0,
		velocity = 0,
		direction = 0
	}
	
	function Player:Load()
		self.x = 32
		self.y = 32
		self.velocity = 50
	end
	
	function Player:Update(dt)
		local delta = (dt * self.velocity)
		if self.direction == 0 then
			self.x = self.x + delta
		elseif self.direction == 1 then
			self.y = self.y + delta
		elseif self.direction == 2 then
			self.x = self.x - delta
		else
			self.y = self.y - delta
		end
	end

	function Player:KeyPressed(key)
		if key == "right" then self.direction = 0
		elseif key == "down" then self.direction = 1
		elseif key == "left" then self.direction = 2
		elseif key == "up" then self.direction = 3
		end
	end
	
	function Player:Draw()
		return love.graphics.rectangle("fill",self.x,self.y,32,32)
	end

	return Player
end