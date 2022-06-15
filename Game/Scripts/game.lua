local Player = require("Scripts.player")

Game = {
	player = Player()
}

function Game:Load()
	self.player:Load()
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