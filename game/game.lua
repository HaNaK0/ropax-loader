local mod = {}

---@class GameObject
---@field update fun(dt: number)
---@field draw fun(self)

---Create a new game
---@return Game
function mod.newGame()
	---@class Game
	---@field objects GameObject[]
	local game = {objects = {}}

	function game:draw()
		for _, object in ipairs(self.objects) do
			object:draw()
		end
	end
	return game
end

return mod
