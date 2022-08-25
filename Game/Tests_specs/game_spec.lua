local mockLove = require("Tests_specs.mocked_love")
local game = require("Scripts.game")


describe('Sanity Check =>', function()
	it("Check Sanity", function()
		assert.is_equal(1, 1)
	end)
end)

describe('Check if main methods exists =>', function()
	it("Load exists", function()
		game:Load()
	end)

	it("Update exists", function()
		local s = spy.on(_G, "error")
		game:Update(1)
		assert.spy(s).was_not_called()
	end)
	
	it("Update cannot be empty", function()
		local s = spy.on(_G, "error")
		game:Update()
		assert.spy(s).was_called()
	end)

	it("Draw exists", function()
		game:Draw()
	end)
end)


describe('Main Calls for Player =>', function()

	local player = require("Scripts.player")()

	it("Check if load calls player load", function()
		local s = spy.on(game.player, "Load")
		
		game:Load()

		assert.spy(s).was_called()
	end)
	
	it("Check if Update calls player Update", function()
		local s = spy.on(game.player, "Update")
		
		game:Update(1)

		assert.spy(s).was_called()
	end)
	
	it("Check if KeyPressed calls player KeyPressed", function()
		local s = spy.on(game.player, "KeyPressed")
		
		game:KeyPressed()

		assert.spy(s).was_called()
	end)
	
	it("Check if Draw calls player Draw", function()
		local s = spy.on(game.player, "Draw")
		
		game:Draw()

		assert.spy(s).was_called()
	end)
end)

describe('Main Calls for Walls => ', function()
	
	local walls = require("Scripts.walls")()

	-- before_each(function()
	-- 	walls = Walls()
	-- end)

	it("Check if Wall Load is being called", function()
		local s = spy.on(game.walls, "Load")
		
		game:Load()

		assert.spy(s).was_called()
	end)
	
	it("Check if Wall Draw is being called", function()
		local s = spy.on(game.walls, "Draw")
		
		game:Draw()

		assert.spy(s).was_called()
	end)

end)