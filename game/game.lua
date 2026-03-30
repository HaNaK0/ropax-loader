local mod = {}

---@class GameObject

---Create a new game
---@return Game
function mod.newGame()
	---@class Game
	---@field objects GameObject[]
	local game = {objects = {}}

	return game
end

return mod
