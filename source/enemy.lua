local pd <const> = playdate
local gfx <const> = pd.graphics

ENEMY = "Enemy"

class(ENEMY).extends()
class(ENEMY).extends(gfx.sprite)

function Enemy:init()
	Enemy.super.init(self)
end

function Enemy:update()
end


function Enemy:collisionResponse()
    return "overlap"
end