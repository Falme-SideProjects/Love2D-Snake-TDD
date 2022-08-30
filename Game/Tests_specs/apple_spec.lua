local mockLove = require("Tests_specs.mocked_love")
local Apple = require("Scripts.apple")
local Grid = require("Scripts.grid")

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

		local type, x, y, w, h = apple:Draw()

		assert.is_equal("fill", type)
		assert.is_equal(0, x)
		assert.is_equal(0, y)
		assert.is_equal(10, w)
		assert.is_equal(10, h)
	end)

	it("Draw Call is correctly set for 40x40 2 grid", function()
		
		grid.width = 40
		grid.height = 40
		grid.scale = 2

		apple:Load(grid)

		local type, x, y, w, h = apple:Draw()

		assert.is_equal("fill", type)
		assert.is_equal(0, x)
		assert.is_equal(0, y)
		assert.is_equal(20, w)
		assert.is_equal(20, h)
	end)

	it("base color is red", function()
		assert.is_equal(236, apple.baseColor.r)
		assert.is_equal(0, apple.baseColor.g)
		assert.is_equal(140, apple.baseColor.b)
		assert.is_equal(255, apple.baseColor.a)
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

		local type, x, y, w, h = apple:Draw()

		assert.is_equal(10, x)
		assert.is_equal(20, y)
	end)

end)