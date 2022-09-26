import "bullet"
import "player"

local pd <const> = playdate
local gfx <const> = pd.graphics

ENEMY_TEST = "EnemyTest"

class(ENEMY_TEST).extends(Enemy)

function EnemyTest:init(x, y) --[[ TBD later, (x, y, direction) ]]
    EnemyTest.super.init(self)
    enemyTestImage = gfx.image.new('images/enemy1_placeholder')
    enemyTestSprite = gfx.sprite.new()

    self:setImage(enemyTestImage)
    self:setCollideRect(0, 0, enemyTestImage:getSize())
    self:setCenter(0.5, 0.5)
    self:moveTo(x, y)
    self:setGroups({2})
    self:setCollidesWithGroups({1})
    self.health = 50
    self.damage = 10
    self:add()
end

function EnemyTest:update()
    enemyX, enemyY = self:getPosition()
    local enemyTrajectory = pd.geometry.lineSegment.new(enemyX, enemyY, playerX, playerY)
    local moveTestEnemy = gfx.animator.new(30 * enemyTrajectory:length(), enemyTrajectory) -- Should be changed for something more dynamic 

    if enemyTrajectory:length() > 0 and invincibleMode == false then
        self:setAnimator(moveTestEnemy)
    else 
        self:removeAnimator(moveTestEnemy)
    end

    if self.health == 0 then
        self:remove()
    end
end