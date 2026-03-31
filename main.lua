local log = require('log')
local game = require('game.game')
local wheels = require('game.wheel')

local objects = {}

---@type WheelParam
local default_wheel = {
	width = 10,
	diameter = 33,
	engine_force = 100,
	braking_force = 100,
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

	objects.wheel = wheels.create_wheel(default_wheel, World, 100, 100)
end

function love.update(dt)
	log:update(dt)
	World:update(dt)

	if love.keyboard.isDown("w") then
		wheels.accelerate(objects.wheel, true)
	elseif love.keyboard.isDown("s") then
		wheels.brake(objects.wheel)
	end

	local wheel_angle = objects.wheel.body:getAngle()
	if love.keyboard.isDown("d") then
		objects.wheel.body:setAngle(wheel_angle + 0.3 * math.pi * dt)
	elseif love.keyboard.isDown("a") then
		objects.wheel.body:setAngle(wheel_angle + -0.3 * math.pi * dt)
	end
end

function love.draw()
	log:draw()

	wheels.draw_wheel(objects.wheel)
end
