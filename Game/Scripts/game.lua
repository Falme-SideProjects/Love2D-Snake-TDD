local Player = require("Scripts.player")
local Grid = require("Scripts.grid")
local Walls = require("Scripts.walls")

Game = {
	player = Player(),
	grid = Grid(),
	walls = Walls()
}

function Game:Load()
	self.grid.width = 500
	self.grid.height = 500
	self.grid.scale = 10

	self.walls:Load(self.grid)
	self.player:Load(self.grid, self.walls)

	self.player:SetPositionAt(1,1)
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
	self.walls:Draw()
end

return Game