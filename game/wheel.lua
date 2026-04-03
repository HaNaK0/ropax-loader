local vector = require('util.vector')
local util = require('util.util')

local wheel = {}

--- The parameters of a wheel 
---@class WheelParam
---@field mass number the mass of the wheel
---@field width number the width of the wheel
---@field diameter number the diameter of the wheel
---@field side_static_friction number the static friction side to side
---@field side_dyn_friction number the dynamic friction sid to side
---@field foreward_static_friction number the static friction foreward which is the max force that can be used to accelerate
---@field foreward_dyn_friction number the dynamic force in the foreward direction
---@field engine_force number the max engine force
---@field braking_force number the max braking force

--- Create a new wheel
---@param desc WheelParam the parameters for the wheel
---@param world love.World the physics world to use
---@param x number x postion to create the wheel at 
---@param y number y postion to create the wheel at
---@param rotation? number the angle of rotation to create the wheel at `0` is looking to the right defaults to `0`
function wheel.create_wheel(desc, world, x, y, rotation)
	rotation = rotation or 0

	--- A class defining a wheel 
	---@class Wheel: GameObject
	---@field desc WheelParam
	---@field body love.Body
	---@field fixture love.Fixture
	---@field shape love.PolygonShape
	---@field turn_target number the terget turning angle
	---@field joint? love.Joint
	local new_wheel = {
		desc = desc,
		turn_target = 0,
	}

	new_wheel.body = love.physics.newBody(world, x, y, "dynamic")
	new_wheel.shape = love.physics.newRectangleShape(desc.diameter ,desc.width)
	new_wheel.fixture = love.physics.newFixture(new_wheel.body, new_wheel.shape, 1)
	new_wheel.body:setAngle(rotation)

	return new_wheel
end

---draw a wheel
---@param a_wheel Wheel the wheel to draw
function wheel.draw_wheel(a_wheel)
	love.graphics.polygon("line", a_wheel.body:getWorldPoints(a_wheel.shape:getPoints()))

	local foreward = util.get_body_foreward(a_wheel.body)
	util.draw_vector(vector.new(a_wheel.body:getPosition()), foreward * 32)

end

--- Update function for a wheel
---@param dt number delta time
---@param a_wheel Wheel the wheel to update
function wheel.update_wheel(dt, a_wheel)
	local direction_normal = util.get_normal(util.get_body_foreward(a_wheel.body))
	local velocity = vector.new(a_wheel.body:getLinearVelocity())
	local side_velocity = velocity:dot(direction_normal)
	local side_friction = direction_normal * -side_velocity * a_wheel.body:getMass()

	a_wheel.body:applyLinearImpulse(side_friction.x, side_friction.y)
end

--- Accelerate the wheel with the given force with positive in the foreward direction
---@param a_wheel Wheel the wheel to use to accelerate
---@param reverse boolean if the vehicle is reversing or not
function wheel.accelerate(a_wheel, reverse)
	reverse = reverse or true
	local foreward = util.get_body_foreward(a_wheel.body)
	local force = foreward * a_wheel.desc.engine_force;

	a_wheel.body:applyForce(force.x, force.y)
end

--- Apply a breaking force on a wheel
---@param a_wheel Wheel
function wheel.brake(a_wheel)
	local foreward = util.get_body_foreward(a_wheel.body)
	local vel_x, vel_y = a_wheel.body:getLinearVelocity()
	local velocity = vector.new(vel_x, vel_y)

	local foreward_velociy = velocity:dot(foreward)
	local braking_force = math.min(a_wheel.desc.braking_force, foreward_velociy ^ 2 * a_wheel.body:getMass() * 0.5)
	local braking_vector = foreward * braking_force * -1

	a_wheel.body:applyForce(braking_vector.x, braking_vector.y)
end

--- Get current angle of a wheel
---@param a_wheel Wheel
function wheel.get_angle(a_wheel)
	a_wheel.body:getAngle()
end

---Get the position for a wheel
---@param a_wheel Wheel
---@return Vector.lua
function wheel.get_posittion(a_wheel)
	return vector.new(a_wheel.body:getPosition())
end

return wheel
