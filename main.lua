local log = require('log')
local vector = require("util.vector")

function love.load()
	log:setup()
	Info(love.graphics.getWidth(), " ", love.graphics.getHeight())

	love.physics.setMeter(64)
	World = love.physics.newWorld(0, 9.182 * 64, true)

	Objects = {}
	Objects.ground = {}
	Objects.ground.body = love.physics.newBody(World, 752/2, 359-25)
	Objects.ground.shape = love.physics.newRectangleShape(750, 50)
	Objects.ground.fixture = love.physics.newFixture(Objects.ground.body, Objects.ground.shape)

	Objects.ball = {}
	Objects.ball.body = love.physics.newBody(World, 752/2, 100, "dynamic")
	Objects.ball.shape = love.physics.newCircleShape(20)
	Objects.ball.fixture = love.physics.newFixture(Objects.ball.body, Objects.ball.shape, 1)

	Objects.ball.fixture:setRestitution(0.9)

	Objects.block1 = {}
	Objects.block1.body = love.physics.newBody(World, 200, 100, "dynamic")
	Objects.block1.shape = love.physics.newRectangleShape(0, 0, 50, 100)
	Objects.block1.fixture = love.physics.newFixture(Objects.block1.body, Objects.block1.shape, 5)

	love.graphics.setBackgroundColor(0.41, 0.53, 0.97)
end

function love.update(dt)
	log:update(dt)
	World:update(dt)

	local touch = love.touch.getTouches()[1]
	if touch ~= nil then
		local ball_pos = vector(
			Objects.ball.body:getX(),
			Objects.ball.body:getY()
		)

		local touch_pos = vector(
			love.touch.getPosition(touch)
		)

		local force = touch_pos - ball_pos
		force:setmag(400)

		Objects.ball.body:applyForce(
			force.x,
			force.y
		)
	end
end

function love.draw()
	log:draw()

	love.graphics.setColor(0.28, 0.63, 0.05)
	love.graphics.polygon(
		"fill",
		Objects.ground.body:getWorldPoints(
			Objects.ground.shape:getPoints()
		)
	)

	love.graphics.setColor(0.76, 0.18, 0.05)
	love.graphics.circle(
		"fill",
		Objects.ball.body:getX(),
		Objects.ball.body:getY(),
		Objects.ball.shape:getRadius()
	)

	love.graphics.setColor(0.5, 0.5, 0.5)
	love.graphics.polygon(
		"fill",
		Objects.block1.body:getWorldPoints(
			Objects.block1.shape:getPoints()
		)
	)
end
