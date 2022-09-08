local mockLove = require("Tests_specs.mocked_love")
local Player = require("Scripts.player")
local Grid = require("Scripts.grid")
local Walls = require("Scripts.walls")
local Apple = require("Scripts.apple")

describe('Player => Positioning =>', function()
	
	local player, grid
	before_each(function()
		player = Player()
		grid = Grid()
		grid.width = 128
		grid.height = 128
		grid.scale = 4
	end)
	
	it("On no load called, player position is 0,0", function()
		assert.is_equal(0, player.x)
		assert.is_equal(0, player.y)
	end)

	it("On Load() called, player position is 32,32", function()
		player:Load(grid)
		player:SetPositionAt(2,2)
		assert.is_equal(64, player.x)
		assert.is_equal(64, player.y)
	end)

	it("Check if on change position, the Point is also updated", function()
		player:Load(grid)
		player:SetPositionAt(2,2)
		assert.is_equal(2, player.pointX)
		assert.is_equal(2, player.pointY)
	end)
end)

describe('Player => Velocity Movement =>', function()
	
	local player, grid
	before_each(function()
		player = Player()
		grid = Grid()
		grid.width = 128
		grid.height = 128
		grid.scale = 4
	end)

	it("On no load called, player velocity is 0", function()
		assert.is_equal(0, player.velocity)
	end)

	it("On Load() called, player velocity is 25", function()
		player:Load(grid)
		assert.is_not_equal(0, player.velocity)
	end)
end)

describe('Player => Movementation Update =>', function()
	
	local player, grid, walls
	before_each(function()
		player = Player()
		grid = Grid()
		walls = Walls()
		grid.width = 128
		grid.height = 128
		grid.scale = 4
		walls:Load(grid)
		player:Load(grid,walls)
	end)

	it("On call update before Load, move to right +1", function()
		player.velocity = 1
		player:Update(1)
		assert.is_equal(32, player.x)
	end)

	it("On call update before Load, NOT move to down +0", function()
		player.velocity = 1
		player:Update(1)
		assert.is_equal(0, player.y)
	end)

	-- LAST DIRECTION TESTS
	it("On a same direction, after moving, cache the lastDirection (right)", function()
		player.velocity = 1
		
		player.direction = 0
		player:Update(1)
		player.direction = 0
		
		assert.is_equal(0, player.direction)
		assert.is_equal(0, player.lastDirection)
	end)

	it("On a same direction, after moving, cache the lastDirection (down)", function()
		player.velocity = 1
		
		player.direction = 1
		player:Update(1)
		player.direction = 1
		
		assert.is_equal(1, player.direction)
		assert.is_equal(1, player.lastDirection)
	end)

	it("On a same direction, after moving, cache the lastDirection (left)", function()
		player.velocity = 1
		
		player.direction = 2
		player:Update(1)
		player.direction = 2
		
		assert.is_equal(2, player.direction)
		assert.is_equal(2, player.lastDirection)
	end)

	it("On a same direction, after moving, cache the lastDirection (up)", function()
		player.velocity = 1
		
		player.direction = 3
		player:Update(1)
		player.direction = 3
		
		assert.is_equal(3, player.direction)
		assert.is_equal(3, player.lastDirection)
	end)

	
	it("last direction is right, and current direction is down", function()
		player.velocity = 1
		
		player.direction = 0
		player:Update(1)
		player:KeyPressed("down")
		
		assert.is_equal(1, player.direction)
		assert.is_equal(0, player.lastDirection)
	end)
	
	it("last direction is right, and current direction is left", function()
		player.velocity = 1
		
		player.direction = 0
		player:Update(1)
		player:KeyPressed("left")
		
		assert.is_equal(0, player.direction)
		assert.is_equal(0, player.lastDirection)
	end)
	
	it("last direction is right, and current direction is down->left", function()
		player.velocity = 1
		
		player.direction = 0
		player:KeyPressed("down")
		player:KeyPressed("left")
		player:Update(1)
		
		assert.is_equal(1, player.direction)
		assert.is_equal(1, player.lastDirection)
	end)

end)

describe('Player => Receiving Input =>', function()
	
	local player
	before_each(function()
		player = Player()
	end)
	
	it("On nothing being called, the direction is right (0)", function()
		assert.is_equal(0, player.direction)
	end)
	
	it("On 'right' being called, the direction is right (0)", function()
		player.direction = 1
		player.lastDirection = player.direction
		player:KeyPressed("right")
		assert.is_equal(0, player.direction)
	end)
	
	it("On 'down' being called, the direction is down (1)", function()
		player:KeyPressed("down")
		assert.is_equal(1, player.direction)
	end)
	
	it("On 'left' being called, the direction is left (2)", function()
		player.direction = 1
		player.lastDirection = player.direction
		player:KeyPressed("left")
		assert.is_equal(2, player.direction)
	end)
	
	it("On 'up' being called, the direction is up (3)", function()
		player:KeyPressed("up")
		assert.is_equal(3, player.direction)
	end)

	
	it("On 'left' being called, and direction currently right the direction is still right (0)", function()
		player.direction = 0
		player.lastDirection = player.direction
		player:KeyPressed("left")
		assert.is_equal(0, player.direction)
	end)

	it("On 'right' being called, and direction currently left the direction is still left (2)", function()
		player.direction = 2
		player.lastDirection = player.direction
		player:KeyPressed("right")
		assert.is_equal(2, player.direction)
	end)
	
	it("On 'up' being called, and direction currently down the direction is still down (1)", function()
		player.direction = 1
		player.lastDirection = player.direction
		player:KeyPressed("up")
		assert.is_equal(1, player.direction)
	end)
	
	it("On 'down' being called, and direction currently up the direction is still up (3)", function()
		player.direction = 3
		player.lastDirection = player.direction
		player:KeyPressed("down")
		assert.is_equal(3, player.direction)
	end)

end)

describe('Check if Player is being drawn =>', function()
	
	local player, grid
	before_each(function()
		player = Player()
		grid = Grid()
		grid.width = 128
		grid.height = 128
		grid.scale = 2
		player:Load(grid)
	end)

	it("Check if Rectangle is being called", function()
		local s = spy.on(love.graphics, "rectangle")
		
		player:Draw()

		assert.spy(s).was_called()
	end)

	it("Check if before load the draw is on 0,0", function()
		--player:Load()
		local t,x,y,w,h = player:Draw()
		assert.is_equal(0, x)
		assert.is_equal(0, y)
	end)

	it("Check if after load the draw is on 64,64", function()
		player:SetPositionAt(1,1)
		local t,x,y,w,h = player:Draw()
		assert.is_equal(64, x)
		assert.is_equal(64, y)
	end)

	it("Check if after load the draw size is 64,64", function()
		player:SetPositionAt(1,1)
		local t,x,y,w,h = player:Draw()
		assert.is_equal(64, w)
		assert.is_equal(64, h)
	end)

end)

describe('Player => Grid Reference =>', function()
	
	local player, grid
	before_each(function()
		player = Player()
		grid = Grid()
		grid.width = 128
		grid.height = 128
		grid.scale = 4
	end)
	
	it("Check if initially the grid is null", function()
		assert.is_equal(nil, player.grid)
	end)
	
	it("Check if initially the grid is not nil after Load()", function()
		player:Load(grid)
		assert.is_not_equal(nil, player.grid)
	end)
end)

describe('Player => Walls Collisions => ', function()
	
	local player, grid, walls
	before_each(function()
		player = Player()
		walls = Walls()
		grid = Grid()
		grid.width = 128
		grid.height = 128
		grid.scale = 4

	end)
	
	it("CheckIfIsWall X Y Method boolean return false", function()
		
		walls:Load(grid)
		player:Load(grid,walls)

		assert.is_equal(false, player:CheckIfIsWall(1,1))
		assert.is_equal(false, player:CheckIfIsWall(2,2))
	end)
	
	it("CheckIfIsWall X Y Method boolean return true", function()
		
		walls:Load(grid)
		player:Load(grid,walls)

		assert.is_equal(true, player:CheckIfIsWall(0,0))
		assert.is_equal(true, player:CheckIfIsWall(1,0))
		assert.is_equal(true, player:CheckIfIsWall(0,1))
		assert.is_equal(true, player:CheckIfIsWall(3,3))
	end)


	it("On player move to a wall, call Death method", function()
		
		walls:Load(grid)
		player:Load(grid,walls)
		player:SetPositionAt(2,2)

		local s = spy.on(player, "Death")
		player:Update(1)
		assert.spy(s).was_called()
		
	end)

	it("On player move to an empty space, do not call Death method", function()
		
		walls:Load(grid)
		player:Load(grid,walls)
		player:SetPositionAt(1,1)

		local s = spy.on(player, "Death")
		player:Update(1)
		assert.spy(s).was_called(0)
		
	end)
end)

describe('Player => Apple Collisions => ', function()
	local player, grid, apple
	before_each(function()
		player = Player()
		apple = Apple()
		grid = Grid()
		grid.width = 128
		grid.height = 128
		grid.scale = 4

	end)

	it("Check if player loads apple", function()
		player:Load(grid,nil,apple)
		assert.is_not_equal(player.apple, nil)
	end)

	it("Collided with an apple returns false", function()

		player:Load(grid, nil, apple)

		apple:SetPosition(3,2);

		assert.is_equal(false, player:CheckIfIsApple(1,2))
	end)

	it("Collided with an apple returns true", function()

		player:Load(grid, nil, apple)

		apple:SetPosition(3,2);

		assert.is_equal(true, player:CheckIfIsApple(3,2))
	end)

	it("Check if Collided with apple is being called", function()
		local s = spy.on(player, "CheckIfIsApple")
		
		player:Load(grid, nil, apple)

		player:Update(1)

		assert.spy(s).was_called(1)
	end)


	it("After the player collided with the apple, re-randomize position", function()
		local s = spy.on(apple, "RandomizePositioning")
		
		local walls = Walls()

		walls:Load(grid)
		player:Load(grid, walls, apple)
		apple:Load(grid)

		player:SetPositionAt(3,2)
		apple:SetPosition(3,2)

		player:Update(0)

		assert.spy(s).was_called(1)
	end)


end)