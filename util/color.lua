---@class ColorTrait
---@field r number red component of colour from in range [0,1]
---@field g number green component of colour from in range [0,1]
---@field b number blue component of colour from in range [0,1]
---@field a number alpha component of colour from in range [0,1]
local color = {}

---Extend a table with the color trait and return the table as an instance with that trait
---@param t table
---@return ColorTrait
function color.extend(t)
	local mt = getmetatable(t) or {}
	local index_table = mt.__index


	return t
end
