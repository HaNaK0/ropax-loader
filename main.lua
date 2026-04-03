local log = require('log')
local wheels = require('game.wheel')
local vehicles = require('game.vehicles')

local objects = {}

function love.load()
	log:setup()
	Info(love.graphics.getWidth(), " ", love.graphics.getHeight())

	love.physics.setMeter(32)
	World = love.physics.newWorld(0, 0, true)

	love.graphics.setBackgroundColor(0.41, 0.53, 0.97)

	objects.tugmaster = vehicles.create_vehicle(World, require('game.vehicles.tugmaster'))
end

function love.update(dt)
	log:update(dt)
	World:update(dt)

	vehicles.update_vehicle(dt, objects.tugmaster)

	if love.keyboard.isDown("w") then
		--wheels.accelerate(objects.wheel, true)
		vehicles.accelerate_vehicle(objects.tugmaster)
	elseif love.keyboard.isDown("s") then
		--wheels.brake(objects.wheel)
		vehicles.brake(objects.tugmaster)
	end

	--local wheel_angle = objects.wheel.body:getAngle()
	local steering_angle = vehicles.get_steeringAngle(objects.tugmaster)
	if love.keyboard.isDown("d") then
		--objects.wheel.body:setAngle(wheel_angle + 0.3 * math.pi * dt)
		vehicles.steer_vehicle(objects.tugmaster, steering_angle + 0.3 * math.pi * dt)
	elseif love.keyboard.isDown("a") then
		--objects.wheel.body:setAngle(wheel_angle + -0.3 * math.pi * dt)
		vehicles.steer_vehicle(objects.tugmaster, steering_angle - 0.3 * math.pi * dt)
	end
end

function love.draw()
	log:draw()

	love.graphics.setColor(0.282, 1, 0)
	vehicles.draw_vehicle(objects.tugmaster)
end
