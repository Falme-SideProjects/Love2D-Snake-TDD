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

	it("Grid 2x2 20,20 returns {0,0},{10,0},{0,10},{10,10}", function()
		
		
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

	
	it("Grid 3x3 30,30 returns {0,0},{10,0},{20,0}," .. 
								"{0,10},	{20,10}," .. 
								"{0,20},{10,20},{20,20}", function()
		
		
		grid.width = 30
		grid.height = 30
		grid.scale = 3

		walls:Load(grid)
		
		local positions = walls:GetWallPositions()
		assert.is_equal(0, positions[1].x)
		assert.is_equal(0, positions[1].y)

		assert.is_equal(10, positions[2].x)
		assert.is_equal(0, positions[2].y)
		
		assert.is_equal(20, positions[3].x)
		assert.is_equal(0, positions[3].y)
		
		
		assert.is_equal(0, positions[4].x)
		assert.is_equal(10, positions[4].y)
		
		assert.is_equal(20, positions[5].x)
		assert.is_equal(10, positions[5].y)

		
		assert.is_equal(0, positions[6].x)
		assert.is_equal(20, positions[6].y)
	end)
end)

describe('Walls => Draw the Walls => ', function()
	
	local walls
	local grid
	before_each(function()
		walls = Walls()
		grid = Grid()
	end)

	it("Check if Draw calls the drawing method", function()
		grid.width = 20
		grid.height = 20
		grid.scale = 2

		walls:Load(grid)

		local s = spy.on(love.graphics, "rectangle")
		walls:Draw()
		assert.spy(s).was_called()
	end)

	it("Check if Draw on 2x2 is being called 4 times", function()
		grid.width = 20
		grid.height = 20
		grid.scale = 2

		walls:Load(grid)
		
		local s = spy.on(love.graphics, "rectangle")
		walls:Draw()
		assert.spy(s).was_called(4)
	end)

	it("Check if Draw on 3x3 is being called 8 times", function()
		grid.width = 30
		grid.height = 30
		grid.scale = 3

		walls:Load(grid)
		
		local s = spy.on(love.graphics, "rectangle")
		walls:Draw()
		assert.spy(s).was_called(8)
	end)

	it("Check if Draw on 4x4 is being called 12 times", function()
		grid.width = 40
		grid.height = 40
		grid.scale = 4

		walls:Load(grid)
		
		local s = spy.on(love.graphics, "rectangle")
		walls:Draw()
		assert.spy(s).was_called(12)
	end)
end)