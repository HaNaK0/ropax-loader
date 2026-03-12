local log = require('log')
local vector = require("util.vector")
local game = require('game.game')
local vehicles = require('game.vehicles')

function love.load()
	log:setup()
	Info(love.graphics.getWidth(), " ", love.graphics.getHeight())

	love.physics.setMeter(64)
	World = love.physics.newWorld(0, 0, true)

	love.graphics.setBackgroundColor(0.41, 0.53, 0.97)

	Game = game.newGame()
	table.insert(Game.objects, vehicles.create_tire(World, 100, 100))
end

function love.update(dt)
	log:update(dt)
	World:update(dt)
end

function love.draw()
	log:draw()

	Game:draw()
end
