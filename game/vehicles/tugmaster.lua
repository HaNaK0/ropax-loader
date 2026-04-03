local vector = require('util.vector')

---@type WheelParam
local wheel_param = {
	width = 10,
	diameter = 33,
	engine_force = 1050,
	braking_force = 1050,
	mass = 10,
	foreward_dyn_friction = 1,
	foreward_static_friction = 1,
	side_dyn_friction = 1,
	side_static_friction = 1,
}

---@type VehicleParam
local params = {
	name = "Tugmaster",
	width = 80,
	legnth = 184,
	engine_force = 1050,
	position = vector.new(200, 200),
	mass = 15,
	wheels = {
		{
			position = vector.new(-72, -35),
			params = wheel_param,
			is_driving = true,
			joint_type = "Fixed",
		},
		{
			position = vector.new(-72, 35),
			params = wheel_param,
			is_driving = true,
			joint_type = "Fixed",
		},
		{
			position = vector.new(55, -35),
			params = wheel_param,
			is_driving = true,
			joint_type = "Left",
		},
		{
			position = vector.new(55, 35),
			params = wheel_param,
			is_driving = true,
			joint_type = "Right",
		},
	},
}

return params
