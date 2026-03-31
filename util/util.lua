local vector = require('util.vector')

local util = {}

--- Get a vector pointing in the foreward direction of a physics body
---@param body love.Body a physics body to get the angle from 
---@return Vector.lua
function util.get_body_foreward(body)
	return vector.fromAngle(-body:getAngle())
end

--- Get a vector that is perpendicular to the given vector
---@param vec Vector.lua
---@return Vector.lua
function util.get_normal(vec)
	return vector.new(-vec.y, vec.x)
end

--- Draw an arrow from the origin pointing in the direction of the vector
---@param origin Vector.lua the origin for the arrow
---@param vec Vector.lua the vector to draw
function util.draw_vector(origin, vec)
	local endpoint = origin + vec
	local right_point = endpoint + vector.fromAngle(vec:heading() + 0.8 * math.pi) * 5
	local left_piont = endpoint + vector.fromAngle(vec:heading() - 0.8 * math.pi) * 5
	love.graphics.line(origin.x, origin.y, endpoint.x, endpoint.y, right_point.x, right_point.y, left_piont.x, left_piont.y, endpoint.x, endpoint.y)
end

return util
