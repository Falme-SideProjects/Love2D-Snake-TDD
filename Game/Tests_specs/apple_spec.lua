local mockLove = require("Tests_specs.mocked_love")
local Apple = require("Scripts.apple")
local Grid = require("Scripts.grid")
local Player = require("Scripts.player")
local Randomizer = require("Scripts.randomizer")
local Walls = require("Scripts.walls")

describe('Apple => Load => ', function()
	
	local apple
	before_each(function()
		apple = Apple()
	end)
	
	it("Grid is nil if not set on Load", function()
		assert.is_equal(nil, apple.grid)
	end)
	
	it("Grid is a table if set on Load", function()
		
		local grid = Grid()

		apple:Load(grid)

		assert.is_not_equal(nil, apple.grid)
	end)
end)

describe('Apple => Positioning =>', function()
	
	local apple
	local grid

	before_each(function()
		apple = Apple()
		grid = Grid()
		grid.width = 40
		grid.height = 40
		grid.scale = 4
		apple:Load(grid)
	end)

	it("Coordinates X and Y exists", function()
		assert.is_equal(apple.pointX, 0)
		assert.is_equal(apple.pointY, 0)
	end)

	it("SetPosition change pointX pointY", function()
		
		apple:SetPosition(2,3)
		assert.is_equal(apple.pointX, 2)
		assert.is_equal(apple.pointY, 3)
	end)
end)

describe('Apple => Draw => ', function()
	
	local grid
	local apple
	
	before_each(function()
		apple = Apple()
		grid = Grid()
	end)

	it("Draw Call a rectangle drawing for apple", function()
		local s = spy.on(love.graphics, "rectangle")
			
		grid.width = 20
		grid.height = 20
		grid.scale = 2

		apple:Load(grid)

		apple:Draw()

		assert.spy(s).was_called(1)
	end)

	it("Draw Call is correctly set for 20x20 2 grid", function()
		
		grid.width = 20
		grid.height = 20
		grid.scale = 2

		apple:Load(grid)

		local drawn = apple:Draw()

		assert.is_equal("fill", drawn[1])
		assert.is_equal(0, drawn[2])
		assert.is_equal(0, drawn[3])
		assert.is_equal(10, drawn[4])
		assert.is_equal(10, drawn[5])
	end)

	it("Draw Call is correctly set for 40x40 2 grid", function()
		
		grid.width = 40
		grid.height = 40
		grid.scale = 2

		apple:Load(grid)

		local drawn = apple:Draw()
		local expect = {"fill", 0, 0, 20, 20}

		assert.are.same(expect, drawn)
	end)

	it("base color is red", function()
		assert.is_equal(236/255, apple.baseColor.r)
		assert.is_equal(0/255, apple.baseColor.g)
		assert.is_equal(140/255, apple.baseColor.b)
		assert.is_equal(255/255, apple.baseColor.a)
	end)

	it("GetBaseColor being called in Draw", function()
		
		grid.width = 20
		grid.height = 20
		grid.scale = 2

		apple:Load(grid)
		
		local s = spy.on(apple, "GetBaseColor")
		
		apple:Draw()

		assert.spy(s).was_called(1)
	end)

	it("Setcolor to baseColor and return to original", function()
		
		grid.width = 20
		grid.height = 20
		grid.scale = 2

		apple:Load(grid)
		
		local s = spy.on(love.graphics, "setColor")
		
		apple:Draw()

		assert.spy(s).was_called(2)
	end)

	it("If position point is on X:1 and Y:2, 40x40:4 , draw at 10x20", function()
		
		grid.width = 40
		grid.height = 40
		grid.scale = 4
		
		apple:Load(grid)
		apple:SetPosition(1,2)

		local drawn = apple:Draw()

		assert.is_equal(10, drawn[2])
		assert.is_equal(20, drawn[3])
	end)

end)

describe('Apple => RandomizePositioning => ', function()
	
	local grid
	local apple
	
	before_each(function()
		apple = Apple()
		grid = Grid()
	end)

	it("RandomizePositioning, grid 1,1 return 0x0", function()
		
		grid.width = 10
		grid.height = 10
		grid.scale = 1
		
		apple:Load(grid)

		apple:SetPosition(3,2)

		apple:RandomizePositioning()

		assert.is_equal(apple.pointX, 0)
		assert.is_equal(apple.pointY, 0)
	end)
	
	it("On randomize apple new position, is calling randomizer", function()
		local s = spy.on(apple.randomizer, "GetRandom")
			
		
		grid.width = 10
		grid.height = 10
		grid.scale = 2
		
		apple:Load(grid)

		apple:SetPosition(3,2)

		apple:RandomizePositioning()

		assert.spy(s).was_called(2)
	end)

	it("RandomizePositioning, grid 2,2 return 0x0,0x1,1x0 or 1x1", function()
		
		local list = {}

		grid.width = 10
		grid.height = 10
		grid.scale = 2
		
		apple:Load(grid)

		for i=1, 30, 1 do
			apple:RandomizePositioning()
			list[apple.pointX .. "" .. apple.pointY] = 1
		end

		assert.is_equal(1, list["00"])
		assert.is_equal(1, list["01"])
		assert.is_equal(1, list["10"])
		assert.is_equal(1, list["11"])
		assert.is_equal(nil, list["20"])
	end)

	it("apple randomized position cannot be on a wall", function()
		
		local list = {}

		grid.width = 10
		grid.height = 10
		grid.scale = 3
		
		apple:Load(grid)

		local walls = Walls()

		walls:Load(grid)

		for i=1, 30, 1 do
			apple:RandomizePositioning(walls:GetWallPositions())
			list[apple.pointX .. "" .. apple.pointY] = 1
		end
		
		assert.is_equal(1, list["11"])
		assert.is_equal(nil, list["10"])
		assert.is_equal(nil, list["20"])
		assert.is_equal(nil, list["01"])
		assert.is_equal(nil, list["21"])
		assert.is_equal(nil, list["02"])
		assert.is_equal(nil, list["12"])
		assert.is_equal(nil, list["22"])
	end)

	
	it("apple randomized position cannot be on player", function()
		
		local list = {}

		grid.width = 10
		grid.height = 10
		grid.scale = 2
		
		local player = Player()

		apple:Load(grid)
		player:Load(grid, nil, apple)
		
		player:SetPositionAt(0,0)

		for i=1, 30, 1 do
			apple:RandomizePositioning(nil, {x=player.pointX,y=player.pointY})
			list[apple.pointX .. "" .. apple.pointY] = 1
		end
		
		assert.is_equal(1, list["11"])
		assert.is_equal(1, list["10"])
		assert.is_equal(1, list["01"])
		assert.is_equal(nil, list["00"])
	end)
	
	it("apple randomized position cannot be on tail", function()
		
		local list = {}

		grid.width = 10
		grid.height = 10
		grid.scale = 2
		
		local player = Player()

		apple:Load(grid)
		player:Load(grid, nil, apple)
		
		--[P][A]
		--[ ][ ]
		apple:SetPosition(1,0)
		player:SetPositionAt(0,0)

		player.direction = 1
		player:Update(1)
		player:AddTail()
		
		player.direction = 0
		player:Update(1)
		player:AddTail()

		for i=1, 30, 1 do
			apple:RandomizePositioning(nil, {x=player.pointX,y=player.pointY}, player.tails)
			list[apple.pointX .. "" .. apple.pointY] = 1
		end
		
		assert.is_equal(nil, list["11"])
		assert.is_equal(1, list["10"])
		assert.is_equal(nil, list["01"])
		assert.is_equal(nil, list["00"])
	end)

end)