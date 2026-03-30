local vector = require('util.vector')

local util = {}

--- Get the foreward vector of a physics body
---@param body love.Body
---@return Vector.lua
function util.get_body_foreward(body)
	return vector.fromAngle(body:getAngle())
end

--- Take the dot product of two vectors
---@param vec_1 Vector.lua
---@param vec_2 Vector.lua
---@return number
function util.dot_product(vec_1, vec_2)
	return vec_1.x * vec_2.x + vec_1.y * vec_2.y
end

return util
