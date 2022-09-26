import "player"
import "enemy"

local pd <const> = playdate
local gfx <const> = pd.graphics

BULLET = 'Bullet'

class(BULLET).extends(gfx.sprite)



function Bullet:init(x, y, direction) 
    bulletImage  = gfx.image.new('images/bullet_placeholder')
    bulletSizeX, bulletSizeY = bulletImage:getSize()

    self:setImage(bulletImage)
    self:setCollideRect(0, 0, bulletSizeX, bulletSizeY)
    self:moveTo(x, y)
    self:setCenter(0.5, 0.5)
    self:setGroups({1})
    self:setCollidesWithGroups({2})
    self.speed = 8
    self.direction = direction
    self.damage = 10
    self:add()

end


function Bullet:update()
    local actualX, actualY, collisions, length
    
    if self.direction == 1 then
        actualX, actualY, collisions, length = self:moveWithCollisions(self.x, self.y - self.speed)
    end
    if self.direction == 2 then
        actualX, actualY, collisions, length = self:moveWithCollisions(self.x + self.speed, self.y - self.speed)
    end
    if self.direction == 3 then
        actualX, actualY, collisions, length = self:moveWithCollisions(self.x + self.speed, self.y)
    end
    if self.direction == 4 then
        actualX, actualY, collisions, length = self:moveWithCollisions(self.x + self.speed, self.y + self.speed)
    end
    if self.direction == 5 then
        actualX, actualY, collisions, length = self:moveWithCollisions(self.x, self.y + self.speed)
    end
    if self.direction == 6 then
        actualX, actualY, collisions, length = self:moveWithCollisions(self.x - self.speed, self.y + self.speed)
    end
    if self.direction == 7 then
        actualX, actualY, collisions, length = self:moveWithCollisions(self.x - self.speed, self.y)
    end
    if self.direction == 8 then
        actualX, actualY, collisions, length = self:moveWithCollisions(self.x - self.speed, self.y - self.speed)
    end

    if length > 0 then
        for index, collision in pairs(collisions) do
            local collidedObject = collision['other']
            if collidedObject:isa(Enemy) then
                collidedObject.health -= self.damage
                print('ENEMY HEALTH:' .. collidedObject.health)
            end
        end
        self:remove()
    elseif actualX > 400 or actualX < 0 or actualY > 240 or actualY < 0 then
        self:remove()
    end
end

function getBulletDirection()

    if playerImage == playerN then
        bulletDirection = 1
    end
    if playerImage == playerNE then
        bulletDirection = 2
    end
    if playerImage == playerE then
        bulletDirection = 3
    end
    if playerImage == playerSE then
        bulletDirection = 4
    end
    if playerImage == playerS then
        bulletDirection = 5
    end
    if playerImage == playerSW then
        bulletDirection = 6
    end
    if playerImage == playerW then
        bulletDirection = 7
    end
    if playerImage == playerNW then
        bulletDirection = 8
    end
    return bulletDirection
end