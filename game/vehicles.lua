local mod = {}

---create a new truck
---@param x number
---@param y number
---@return Truck
function mod.create_truck(x, y)
	---@class Truck: GameObject
	---@field private sprite love.Image
	---@field x number
	---@field y number
	local truck = {
		x = x,
		y = y,
		sprite = love.graphics.newImage("assets/sprites/tugmaster.png"),
	}

	function truck:update(dt)
		--TODO
	end

	function truck:draw()
		love.graphics.draw(self.sprite, self.x, self.y)
	end

	return truck
end

---Create a tire for a vehivcle
---@param world love.World the physics world this tire is conected to
---@param x number x postion
---@param y number y position
function mod.create_tire(world, x, y)
	---@class Tire: GameObject
	---@field body love.Body
	---@field shape love.PolygonShape
	---@field fixture love.Fixture
	local tire = {}

	tire.body = love.physics.newBody(world, x, y, "dynamic")
	tire.shape = love.physics.newRectangleShape(19,66)
	tire.fixture = love.physics.newFixture(tire.body, tire.shape, 1)

	function tire:draw()
		love.graphics.setColor(0.282, 1, 0)
		love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
	end

	return tire
end

return mod
