local mockLove = require("Tests_specs.mocked_love")
local Walls = require("Scripts.walls")
local Grid = require("Scripts.grid")

describe('Sanity Check =>', function()
	it("Check Sanity", function()
		assert.is_equal(1, 1)
	end)
end)

describe('Walls => Get All positions of grid =>', function()
	
	local grid
	local walls

	before_each(function()
		grid = Grid()
		walls = Walls()
	end)

	it("Grid 2x2 20,20 returns {0,0},{20,0},{0,20},{20,20}", function()
		
		
		grid.width = 20
		grid.height = 20
		grid.scale = 2

		walls:Load(grid)
		
		local positions = walls:GetWallPositions()
		assert.is_equal(0, positions[1].x)
		assert.is_equal(0, positions[1].y)

		assert.is_equal(10, positions[2].x)
		assert.is_equal(0, positions[2].y)

		assert.is_equal(0, positions[3].x)
		assert.is_equal(10, positions[3].y)

		assert.is_equal(10, positions[4].x)
		assert.is_equal(10, positions[4].y)
	end)
end)