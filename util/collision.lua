require("util.vector")

local collission = {}

---check if a point is within a circle
---@param point Vector.lua the point to check
---@param centre Vector.lua the centre of the circle
---@param radius number the radius of the circle
---@return boolean
function collission.point_vs_circle(point, centre, radius)
	local diff = point - centre
	return diff:magSq() <= radius ^ 2
end

---Check a point vs an axis aligned bounding box
---@param point Vector.lua the point to check
---@param origin Vector.lua the top left corner of the box
---@param size Vector.lua the size of the bounding box
---@return boolean
function collission.point_vs_aabb(point, origin, size)
	local diff = point - origin
	return diff.x >= 0 and diff.x <= size.x and diff.y >= 0 and diff.y <= size.y
end
return collission
