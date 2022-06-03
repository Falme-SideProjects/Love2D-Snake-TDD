local game = require("Scripts.game")

_G.error = function(message, levels) return true end
_G.love = {
	graphics = {
		print = function(text, x, y) end
	}
}

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

