local log = require('log')

function love.load()
	log:setup()
	love.physics.setMeter(64)
	love.physics.newWorld(0, 0, true)

	Objects = {}
	Objects.ground = {}
	
end

function love.update(dt)
	log:update(dt)
	Info(love.graphics.getWidth(), " ", love.graphics.getHeight())
end

function love.draw()
	log:draw()
end
