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

---create a new wheel
---@param desc WheelParam
---@param world love.World
---@param x number
---@param y number
function wheel.create_wheel(desc, world, x, y)

	--- A class defining a wheel 
	---@class Wheel: GameObject
	---@field desc WheelParam
	---@field body love.Body
	---@field fixture love.Fixture
	---@field shape love.PolygonShape
	local new_wheel = {
		desc = desc,
	}

	new_wheel.body = love.physics.newBody(world, x, y, "dynamic")
	new_wheel.shape = love.physics.newRectangleShape(desc.diameter ,desc.width)
	new_wheel.fixture = love.physics.newFixture(new_wheel.body, new_wheel.shape, 1)

	function new_wheel:draw()
		love.graphics.setColor(0.282, 1, 0)
		love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
	end

	return new_wheel
end


return wheel
