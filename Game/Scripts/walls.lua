return function()
	local Walls = {
		grid=nil,
		positions={}
	}

	function Walls:Load(grid)
		self.grid = grid
		self.positions = self:DefineWallPositions()
	end
	-- self.grid:GetPositionAt(j,i)
	function Walls:DefineWallPositions()
		local result = {}

		for i = 0, self.grid.scale-1, 1 do
			for j = 0, self.grid.scale-1, 1 do
				if(i > 0 and i < self.grid.scale-1 and j>0) then 
					j = self.grid.scale-1
					table.insert(result,{x=j,y=i})
					break
				end
				table.insert(result,{x=j,y=i})
			end
		end

		return result
	end

	function Walls:GetWallPositions()
		return self.positions
	end

	function Walls:Draw()

		local places = self:GetWallPositions()

		for _, coord in ipairs(places) do
			love.graphics.rectangle("fill", self.grid:GetPositionAt(coord.x,coord.y).x, self.grid:GetPositionAt(coord.x,coord.y).y,(self.grid.width/self.grid.scale),(self.grid.height/self.grid.scale))
		end
	end

	return Walls
end