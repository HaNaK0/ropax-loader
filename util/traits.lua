require("log")
local traits = {}

---@class Trait

---Implements specified trait on a table
---@param t table
---@param trait Trait
function traits.implement(t, trait)
	local mt = getmetatable(t)
	if mt == nil then
		mt = {}
		setmetatable(t, mt)
	end
	if mt._traits == nil then
		mt._traits = {}
	end
	local _traits = mt._traits
	if _traits[trait] ~= nil then
		Warn("reimplementing trait ", trait, " on ", t)
	end
	_traits[trait] = true

	if mt.__index ~= traits.index and mt.__index ~= nil then
		Warn("overwriting index method on ", t)
	end
	mt.__index = traits.index
end

function traits.index(t, key)
	print("hello")

	return nil
end
