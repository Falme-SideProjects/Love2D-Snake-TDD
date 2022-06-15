local game = require("Scripts.game")

function love.load()
	game:Load()
end

function love.update(dt)
	game:Update(dt)
end

function love.keypressed(key)
	game:KeyPressed(key)
end

function love.draw()
	game:Draw()
end  