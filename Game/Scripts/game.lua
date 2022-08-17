local Player = require("Scripts.player")
local Grid = require("Scripts.grid")

Game = {
	player = Player(),
	grid = Grid()
}

function Game:Load()
	self.grid.width = 500
	self.grid.height = 500
	self.grid.scale = 10

	self.player:Load(self.grid)
end

function Game:Update(dt)
	if dt == nil then 
		error("DeltaTime cannot be nil")
		return
	end

	self.player:Update(dt)
end

function Game:KeyPressed(key)
	self.player:KeyPressed(key)
end

function Game:Draw()
	self.player:Draw()
end

return Game