return function()
	local Walls = {
		grid=nil,

	}

	function Walls:Load(grid)
		self.grid = grid
	end

	function Walls:GetWallPositions()

		local result = {}

		for i = 0, self.grid.scale-1, 1 do
			for j = 0, self.grid.scale-1, 1 do
				table.insert(result,self.grid:GetPositionAt(j,i))
			end
		end

		return result
	end

	return Walls
end