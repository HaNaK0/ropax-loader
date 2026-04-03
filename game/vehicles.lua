local wheels = require('game.wheel')
local util   = require('util.util')
local vector = require('util.vector')

local mod = {}

--- Enum for setting how a wheel is attached to a vehicle
---@alias WheelJointType
---| '"Left"' # a turning wheel on the left side of the vehicle
---| '"Right"' # a turning wheel to the right side of the vehicle
---| '"Fixed"' # a fixed wheel that cant turn

--- The parameters for how a wheel is attached and interacts with a vehicle
---@class VehicleWheelParam
---@field params WheelParam the params for the wheel
---@field position Vector.lua the position of the tire realtive to the vehicle
---@field joint_type WheelJointType the type of the joint
---@field is_driving boolean if this wheel is a driving wheel

--- The parameters defining a vehicle
---@class VehicleParam
---@field name string
---@field width number the width of the vehicle
---@field legnth number the legnth of the vehicle
---@field position Vector.lua the position to create the vhicle at
---@field engine_force number the engine force for this vehicle
---@field wheels VehicleWheelParam[] the params for the vehicles wheels
---@field mass number the weight of the vehicle

--- Create a new vehicle
---@param world love.World
---@param params VehicleParam
---@return Vehicle
function mod.create_vehicle(world, params)
	--- A class for a table used to simulate a vehicle
	---@class (exact) Vehicle
	---@field body love.Body the physics body for this Vehicle
	---@field shape love.PolygonShape the shaoe of this vehicle 
	---@field fixture love.Fixture the physics fixture fir this vehicle
	---@field wheels Wheel[] the wheels of this vehicle
	---@field fixed_joints love.WeldJoint[] the joints for the wheel that is not used to steer
	---@field steer_joints love.RevoluteJoint[] the joints for the wheels that can be used to steer
	---@field params VehicleParam the parameters this vehicle was created from
	---@field steering_angle number the current angle the vehicle is steering
	local new_vehicle = {
		body = love.physics.newBody(world, params.position.x, params.position.y, "dynamic"),
		shape = love.physics.newRectangleShape(params.legnth, params.width),
		wheels = {},
		fixed_joints = {},
		steer_joints = {},
		steering_angle = 0,
	}

	new_vehicle.fixture = love.physics.newFixture(new_vehicle.body, new_vehicle.shape, params.mass / ((params.legnth / 32) * (params.width/ 32)))

	for i,v in ipairs(params.wheels) do
		local wheel_position = params.position + v.position
		local new_wheel = wheels.create_wheel(v.params, world, wheel_position.x, wheel_position.y)

		if v.joint_type == "Fixed" then
			local joint = love.physics.newWeldJoint(new_vehicle.body, new_wheel.body, wheel_position.x, wheel_position.y)
			joint:setUserData(v.joint_type)
			table.insert(new_vehicle.fixed_joints, joint)
		else -- if the joint type is `Left` or `Right`
			local joint = love.physics.newRevoluteJoint(new_vehicle.body, new_wheel.body, wheel_position.x, wheel_position.y, false)
			joint:setUserData(v.joint_type)
			joint:setMotorEnabled(true)
			joint:setMaxMotorTorque(1000)
			table.insert(new_vehicle.steer_joints, joint)
		end

		new_vehicle.wheels[i] = new_wheel
	end

	return new_vehicle
end

--- Draw a vehicle
---@param vehicle Vehicle the vehicle to draw
function mod.draw_vehicle(vehicle)
	for _, wheel in ipairs(vehicle.wheels) do
		wheels.draw_wheel(wheel)
	end

	love.graphics.polygon("line",vehicle.body:getWorldPoints(vehicle.shape:getPoints()))

end

--- Updates a vehicle
--- @param dt number
--- @param vehicle Vehicle
function mod.update_vehicle(dt, vehicle)
	for _, joint in ipairs(vehicle.steer_joints) do
		local angle_diff = vehicle.steering_angle - joint:getJointAngle()
		joint:setMotorSpeed(angle_diff  * 10)
	end

	for _, wheel in ipairs(vehicle.wheels) do
		wheels.update_wheel(dt, wheel)
	end
end

--- Steer the vehicle
---@param vehicle Vehicle the vehicle to steer
---@param angle number the steering angle
function mod.steer_vehicle(vehicle, angle)
	if #vehicle.steer_joints == 0 then
		Warn("Vehicle ", vehicle.params.name, " does not have any steerable wheels and can't be steered")
	end

	vehicle.steering_angle = angle
end

--- Get the current sttering angle by getting the angle offset of the motor joint
---@param vehicle Vehicle 
---@return number
function mod.get_steeringAngle(vehicle)
	if #vehicle.steer_joints == 0 then
		Warn("Trying to get the the sttering angle from a ", vehicle.params.name ," without steerable wheels")
		return 0
	end

	return vehicle.steering_angle
end

---Accelerates a vehicle
---@param vehicle Vehicle
function mod.accelerate_vehicle(vehicle)
	if #vehicle.wheels == 0 then
		Warn("Vehicle ", vehicle.params.name ," does not have any wheels and can not accelerate")
		return
	end

	for _, wheel in ipairs(vehicle.wheels) do
		wheels.accelerate(wheel,false)
	end
end

function mod.brake(vehicle)
	if #vehicle.wheels == 0 then
		Warn("Vehicle ", vehicle.params.name ," does not have any wheels and can not brake")
		return
	end

	for _, wheel in ipairs(vehicle.wheels) do
		wheels.brake(wheel)
	end
end

return mod
