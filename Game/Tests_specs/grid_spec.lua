local mockLove = require("Tests_specs.mocked_love")
local Grid = require("Scripts.grid")

describe('Grid => Get Position in Grid (Pixels) =>', function()
	
	local grid
	before_each(function()
		grid = Grid()
	end)

	it("Get on 0,0 returns 0,0", function()
		
		local position = grid:GetPositionAt(0,0)
		
		assert.is_equal(0, position.x)
		assert.is_equal(0, position.y)
	end)

	it("Get on 1,1 returns 10,10 [100,100,10]", function()
		
		grid.width = 100
		grid.height = 100
		grid.scale = 10

		local position = grid:GetPositionAt(1,1)
		
		assert.is_equal(10, position.x)
		assert.is_equal(10, position.y)
	end)

	it("Get on 2,0 returns 20,0 [100,100,10]", function()
		
		grid.width = 100
		grid.height = 100
		grid.scale = 10

		local position = grid:GetPositionAt(2,0)
		
		assert.is_equal(20, position.x)
		assert.is_equal(0, position.y)
	end)
	

	it("Get on 2,-1 returns 20,0 [100,100,10]", function()
		
		grid.width = 100
		grid.height = 100
		grid.scale = 10

		local position = grid:GetPositionAt(2,-1)
		
		assert.is_equal(20, position.x)
		assert.is_equal(0, position.y)
	end)
	

	it("Get on -2,-1 returns 0,0 [100,100,10]", function()
		
		grid.width = 100
		grid.height = 100
		grid.scale = 10

		local position = grid:GetPositionAt(-2,-1)
		
		assert.is_equal(0, position.x)
		assert.is_equal(0, position.y)
	end)
	
	it("Get on 10,11 returns 90,90 [100,100,10]", function()
		
		grid.width = 100
		grid.height = 100
		grid.scale = 10

		local position = grid:GetPositionAt(10,11)
		
		assert.is_equal(90, position.x)
		assert.is_equal(90, position.y)
	end)

	it("Get on 9,9 returns 90,90 [100,100,10]", function()
		
		grid.width = 100
		grid.height = 100
		grid.scale = 10

		local position = grid:GetPositionAt(9,9)
		
		assert.is_equal(90, position.x)
		assert.is_equal(90, position.y)
	end)
end)