local log = require('log')
local game = require('game.game')
local wheels = require('game.wheel')

---@type WheelParam
local default_wheel = {
	width = 10,
	diameter = 33,
	engine_force = 1,
	braking_force = 1,
	mass = 10,
	foreward_dyn_friction = 1,
	foreward_static_friction = 1,
	side_dyn_friction = 1,
	side_static_friction = 1,
}

function love.load()
	log:setup()
	Info(love.graphics.getWidth(), " ", love.graphics.getHeight())

	love.physics.setMeter(32)
	World = love.physics.newWorld(0, 0, true)

	love.graphics.setBackgroundColor(0.41, 0.53, 0.97)

	Game = game.newGame()
	table.insert(Game.objects, wheels.create_wheel(default_wheel, World, 100, 100))
end

function love.update(dt)
	log:update(dt)
	World:update(dt)
end

function love.draw()
	log:draw()

	Game:draw()
end
