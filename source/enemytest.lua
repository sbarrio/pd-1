import "bullet"

local pd <const> = playdate
local gfx <const> = pd.graphics

ENEMY_TEST = "EnemyTest"

class(ENEMY_TEST).extends(Enemy)

function EnemyTest:init(x, y) --[[ TBD later, (x, y, direction) ]]
    EnemyTest.super.init(self)
    enemyTestImage = gfx.image.new('images/enemy1_placeholder')

    self:setImage(enemyTestImage)
    self:setCollideRect(0, 0, self:getSize())
    self:moveTo(x, y)
    self.speed = 0
    self.health = 50
    self:add()
end

function EnemyTest:update()
    if self.health == 0 then
        self:remove()
    end
end